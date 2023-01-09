/**
* Name: potsdam
* Author: Leonard Higi
* Description: 
* Tags: Tag1, Tag2, TagN
*/
model Schlaatz_PP

/* Insert your model definition here */
global {
	file<geometry> shape_buildings_ALKIS <- shape_file("../includes/1912 Schlaatz Potsdam Buildings public.shp", "EPSG:3857");
	file<geometry> shape_parkplaetze <- shape_file("../includes/191106 Parkplätze Schlaatz 1819.shp", "EPSG:3857");
	file<geometry> shape_POI <- shape_file("../includes/190815 POI 1359.shp", "EPSG:3857");
	file background_schlaatz <- file("../includes/Background Schlaatz Logo Disclaimer.jpg");
	file<geometry> shape_neubau <- shape_file("../includes/190827 Neubau.shp", "EPSG:3857");
	geometry shape <- envelope(envelope(shape_buildings_ALKIS));
	file renter_data_file <- csv_file("../includes/Mieterbefragung Auswertung public.csv", ";");
	matrix renter_data <- matrix(renter_data_file);
	map<string, float> renter_1room_age_map;
	map<string, float> renter_2room_age_map;
	map<string, float> renter_3room_age_map;
	map<string, float> renter_4room_age_map;
	map<string, float> renter_1room_education_map;
	map<string, float> renter_2room_education_map;
	map<string, float> renter_3room_education_map;
	map<string, float> renter_4room_education_map;
	map<string, float> renter_1room_income_map;
	map<string, float> renter_2room_income_map;
	map<string, float> renter_3room_income_map;
	map<string, float> renter_4room_income_map;
	map<string, int> household_type_survival_time_map <- ["YS"::5, "YC"::5, "ES"::20, "EC"::30, "F"::18, "SPF"::12, "FS"::5];
	float wp_YS <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Junge Singles" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_YC <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Junge Lebensgemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_ES <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Ältere Singles" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_EC <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Ältere Lebensgemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_F <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Familie" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_SPF <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Familie, alleinerziehend" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float wp_FS <- 0.5 min: 0.2 max: 0.8 step: 0.01 parameter: "Wohngemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Zahlungsbereitschaft (Miete/Nettoeinkommen Hauptmieter)";
	float sp_YS <- 0.59 min: 0.0 max: 3.0 step: 0.1 parameter: "Junge Singles" on_change: {
		ask buildings {
			do update_ratio_parkinglots_flats_required;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_YC <- 0.59 min: 0.0 max: 3.0 step: 0.1 parameter: "Junge Lebensgemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_ES <- 0.7 min: 0.0 max: 3.0 step: 0.1 parameter: "Ältere Singles" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_EC <- 0.7 min: 0.0 max: 3.0 step: 0.1 parameter: "Ältere Lebensgemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_F <- 1.12 min: 0.0 max: 3.0 step: 0.1 parameter: "Familie" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_SPF <- 0.66 min: 0.0 max: 3.0 step: 0.1 parameter: "Familie, alleinerziehend" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	float sp_FS <- 0.59 min: 0.0 max: 3.0 step: 0.1 parameter: "Wohngemeinschaft" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	int sp_distance <- 100 min: 50 max: 800 step: 50 parameter: "Entfernung Stellplatz" on_change: {
		ask renter {
			do update_willingness_to_pay;
		}

	}

	category: "Stellplatzschlüssel";
	map<int, string> building_name_map;
	map<int, int> flats_total_map;
	map<int, int> flats_2room_map;
	map<int, int> flats_3room_map;
	map<int, int> flats_4room_map;
	map<int, float> flats_rent_map;
	map<int, float> fluctuation_map;
	map<int, float> energy_consumption_ref_map;
	map<int, string> renter_type_edu_map;
	map<int, int> renter_type_income_map;
	map<int, int> refurbishment_start_map;
	map<int, int> refurbishment_end_map;
	bool start_time <- false;
	bool energieverbrauch <- false;
	bool sanierungszeiten <- true;
	bool barrierearm <- false;
	bool sanierungsstatus <- false;
	bool eigentum <- true;
	bool attractivity <- false;
	int month <- 1;
	int year <- 2020;
	int month_2 <- 1;
	int year_2 <- 2020;
	list building_saniert;
	list building_teilsaniert;
	list building_unsaniert;
	list energ_5;
	list energ_6;
	list energ_7;
	list energ_8;
	list energ_9;
	list energ_1;
	list rent_history_schlaatz_PP;
	float rent_schlaatz_PP;
	list energy_history_schlaatz_PP;
	float energy_saved_schlaatz_PP;
	list<float> attractivity_total;
	float attractivity_max;
	map<string, float> attr_weight_school <- ["YS"::0.012, "YC"::0.024, "ES"::0.011, "EC"::0.010, "F"::0.055, "SPF"::0.074, "FS"::0.013];
	map<string, float> attr_weight_pt_u500 <- ["YS"::0.024, "YC"::0.024, "ES"::0.045, "EC"::0.041, "F"::0.027, "SPF"::0.028, "FS"::0.026];
	map<string, float> attr_weight_pt_o500 <- ["YS"::0.060, "YC"::0.046, "ES"::0.011, "EC"::0.010, "F"::0.018, "SPF"::0.018, "FS"::0.064];
	map<string, float> attr_weight_shop_u500 <- ["YS"::0.024, "YC"::0.024, "ES"::0.045, "EC"::0.041, "F"::0.027, "SPF"::0.028, "FS"::0.026];

	//Slider User Interaction Inflation
	float inflation <- 0.02 min: 0.0 max: 0.1 step: 0.01 parameter: "Jährliche Inflationsrate";
	float rent_increase_new <- 0.05 min: 0.0 max: 0.2 step: 0.01 parameter: "Mieterhöhung Neuvermietung";
	int number_interested_renters <- 400 min: 100 max: 3000 step: 100 parameter: "Mietinteressenten";
	list neuvermietung;
	list offers;
	string fluctuation_mode <- "Fluktuation nach Haushaltstypen" among: ["Fluktuationsrate 2019", "Fluktuation nach Haushaltstypen"] parameter: "Berechnung Fluktuation =";
	string attractivity_map <- "YS" among: ["YS", "YC", "ES", "EC", "F", "SPF", "FS"] parameter: "Attraktivität für Haushaltstyp:" category: "Attraktivitäts-Map";
	bool consider_soft_criteria <- true parameter: "Weiche Kriterien berücksichtigen" category: "Attraktivitäts-Map";
	bool pt_near_vis <- true parameter: "ÖPNV < 500m" on_change: {
		do calculate_attractivity;
	}

	category: "Attraktivitäts-Map";
	bool pt_far_vis <- true parameter: "ÖPNV < 1000m" on_change: {
		do calculate_attractivity;
	}

	category: "Attraktivitäts-Map";
	bool edu_vis <- true parameter: "Schulen" on_change: {
		do calculate_attractivity;
	}

	category: "Attraktivitäts-Map";
	int distance_school <- 250 min: 100 max: 1000 step: 50 parameter: "Distanz Schule – Entscheidungskriterium" on_change: {
		do calculate_attractivity;
	}

	category: "Attraktivitäts-Map";
	bool shop_vis <- true parameter: "Einkaufen <500m" on_change: {
		do calculate_attractivity;
	}

	category: "Attraktivitäts-Map";
	user_command neu_berechnen action: calculate_attractivity category: "Attraktivitäts-Map";
	user_command Neubau action: construct_building category: "Neubau";
	int flats_1room_new <- 20 min: 0 max: 100 step: 1 parameter: "1-Raum-Wohnungen" category: "Neubau";
	int flats_2room_new <- 20 min: 0 max: 100 step: 1 parameter: "2-Raum-Wohnungen" category: "Neubau";
	int flats_3room_new <- 20 min: 0 max: 100 step: 1 parameter: "3-Raum-Wohnungen" category: "Neubau";
	int flats_4room_new <- 20 min: 0 max: 100 step: 1 parameter: "4-Raum-Wohnungen" category: "Neubau";
	int flats_5room_new <- 20 min: 0 max: 100 step: 1 parameter: "5-Raum-Wohnungen" category: "Neubau";
	int flats_6room_new <- 20 min: 0 max: 100 step: 1 parameter: "6-Raum-Wohnungen" category: "Neubau";
	bool barrierefrei_new <- true parameter: "barrierefrei" category: "Neubau";
	float wbs_new <- 0.375 min: 0.0 max: 1.0 step: 0.001 parameter: "Belegungsbindung WBS" category: "Neubau";
	float wbs40_new <- 0.375 min: 0.0 max: 1.0 step: 0.001 parameter: "Belegungsbindung WBS 40+" category: "Neubau";
	user_command Neubau_mit_Click_bauen action: lets_construct category: "Neubau";
	bool construction_permit <- false;

	////Map hard criteria decision-making per household type for GUI display (based on Haase et al. 2010)
	map<string, string>
	hht_map_age <- ["YS"::"18-<45 Jahre", "YC"::"18-<45 Jahre", "ES"::">45 Jahre", "EC"::">45 Jahre", "F"::"18-<45 Jahre", "SPF"::"18-<45 Jahre", "FS"::"18-<45 Jahre"];
	map<string, string>
	hht_map_roomsflat <- ["YS"::"1-Raum Wohnung", "YC"::"2-3-Raum Wohnung", "ES"::"1-2-Raum Wohnung", "EC"::"2-5-Raum Wohnung", "F"::"3-5-Raum Wohnung", "SPF"::"1-3-Raum Wohnung", "FS"::"2-4-Raum Wohnung"];
	map<string, string> hht_map_survival_time <- ["YS"::"5 Jahre", "YC"::"5 Jahre", "ES"::"20 Jahre", "EC"::"30 Jahre", "F"::"18 Jahre", "SPF"::"12 Jahre", "FS"::"5 Jahre"];

	// Randomly chosen renters as representatives of household types in GUI display
	renter renter_YS;
	renter renter_YC;
	renter renter_ES;
	renter renter_EC;
	renter renter_F;
	renter renter_SPF;
	renter renter_FS;

	init {
		loop i from: 1 to: 6 {
			add (renter_data[i, 0]::renter_data[i, 1]) to: renter_1room_age_map;
		}

		loop i from: 1 to: 6 {
			add (renter_data[i, 0]::renter_data[i, 2]) to: renter_2room_age_map;
		}

		loop i from: 1 to: 6 {
			add (renter_data[i, 0]::renter_data[i, 3]) to: renter_3room_age_map;
		}

		loop i from: 1 to: 6 {
			add (renter_data[i, 0]::renter_data[i, 4]) to: renter_4room_age_map;
		}

		loop i from: 8 to: 11 {
			add (renter_data[i, 0]::renter_data[i, 1]) to: renter_1room_education_map;
		}

		loop i from: 8 to: 11 {
			add (renter_data[i, 0]::renter_data[i, 2]) to: renter_2room_education_map;
		}

		loop i from: 8 to: 11 {
			add (renter_data[i, 0]::renter_data[i, 3]) to: renter_3room_education_map;
		}

		loop i from: 8 to: 11 {
			add (renter_data[i, 0]::renter_data[i, 4]) to: renter_4room_education_map;
		}

		loop i from: 13 to: 24 {
			add (renter_data[i, 0]::renter_data[i, 1]) to: renter_1room_income_map;
		}

		loop i from: 13 to: 24 {
			add (renter_data[i, 0]::renter_data[i, 2]) to: renter_2room_income_map;
		}

		loop i from: 13 to: 24 {
			add (renter_data[i, 0]::renter_data[i, 3]) to: renter_3room_income_map;
		}

		loop i from: 13 to: 24 {
			add (renter_data[i, 0]::renter_data[i, 4]) to: renter_4room_income_map;
		}
		//write flats_total_map;
		//write building_name_map;
		//write flats_rent_map;
		write renter_1room_age_map;
		write renter_2room_age_map;
		write renter_3room_age_map;
		write renter_4room_age_map;
		write renter_1room_education_map;
		write renter_2room_education_map;
		write renter_3room_education_map;
		write renter_4room_education_map;
		write renter_1room_income_map;
		write renter_2room_income_map;
		write renter_3room_income_map;
		write renter_4room_income_map;
		write fluctuation_map;
		create buildings from: shape_buildings_ALKIS with:
		[building_height::float(get("objekthoeh")), description::string(read("funktion")), street::string(read("Thorough_1")), housenumber::int(read("Thoroughfa")), building_name::string(read("gebadresse")), name:: string(read("gebadresse")), flats_1room::int(read("1room")), flats_1room::int(read("1room")), flats_2room::int(read("2room")), flats_3room::int(read("3room")), flats_4room::int(read("4room")), flats_5room::int(read("5room")), flats_total::int(read("flatstotal")), property_of::string(read("eigentum")), state_refurbishment::string(read("sanierung")), barrierearm_building::int(read("aufzug")), rent::float(read("NKM")), rent::float(read("NKM")), year_of_refurbishment_start::int(read("sanbeginn")), year_of_refurbishment_end::int(read("sanende")), fluctuation::float(read("flukt")), belegungsbindung::float(read("belegbind")), rent_WBS::float(read("WBS")), energy_consumption_ref::float(read("energsan")), energy_consumption_act::1.0, EGschwelle::int(read("EGschwelle")), school::string(read("school")), edu_bool::int(read("edu_bool")), shop_bool::int(read("shop_bool"))];
		create parking_lot from: shape_parkplaetze with: [nutzung::string(read("nutzung")), assigned_building::string(read("assigned"))];
		create POI from: shape_POI with: [name:: string(read("Adresse")), pt_bool::int(get("pt_bool")), pt_type::string(read("pt_type"))];
		ask buildings {
			color_state_refurbishment <- state_refurbishment = "saniert" ? #green : (state_refurbishment = "teilsaniert" ? #yellow : (state_refurbishment = "unsaniert" ?
			#red : (state_refurbishment = "under_construction" ? #darkviolet : #blue)));
			color_property_of <- property_of = "pbg eG" ? #yellow : (property_of = "DtWohnen" ? #darkred : (property_of = "BVA" ? #gamared : (property_of = "BVB" ?
			#wheat : (property_of = "HVEichsfeld" ? #yellowgreen : (property_of = "Talis" ? #forestgreen : (property_of = "ProPotsdam" ? #cornflowerblue : (property_of = "PWG1956 eG" ?
			#darkviolet : (property_of = "WBGKarlMarx" ? #gamablue : (property_of = "Infra / KIS" ? #dimgrey : (property_of = "Gewerbe" ? #lightgrey : #orange))))))))));
			color_barrierearm <- barrierearm_building = 1 ? #yellow : (EGschwelle = 1 ? #darkorange : #red);
		}

		ask parking_lot {
			color_property <- nutzung = "gewerbe" ? #white : (nutzung = "infra" ? #grey : (nutzung = "privat" ? #blue : (nutzung = "karlmarx" ? #gamablue : #cornflowerblue)));
		}

		ask buildings where (each.property_of = "ProPotsdam" or each.property_of = "pbg eG" or each.property_of = "PWG1956 eG" or each.property_of = "WBGKarlMarx") { //self.location <- set_z(self.location, 2, 0.0);


		//Zuweisung soziodemographische Merkmale Mieter auf Grundlage Mieterbefragung 2017 Datenset Schlaatz
			create renter number: flats_1room with:
			[flat_rooms::1, my_building::self.building_name, my_building_agent::self, location::self.location, age_class::renter_1room_age_map.keys[rnd_choice(renter_1room_age_map.values)], education::renter_1room_education_map.keys[rnd_choice(renter_1room_education_map.values)], income_class::renter_1room_income_map.keys[rnd_choice(renter_1room_income_map.values)], old_new::"old"];
			create renter number: flats_2room with:
			[flat_rooms::2, my_building::self.building_name, my_building_agent::self, location::self.location, age_class::renter_2room_age_map.keys[rnd_choice(renter_2room_age_map.values)], education::renter_2room_education_map.keys[rnd_choice(renter_2room_education_map.values)], income_class::renter_2room_income_map.keys[rnd_choice(renter_2room_income_map.values)], old_new::"old"];
			create renter number: flats_3room with:
			[flat_rooms::3, my_building::self.building_name, my_building_agent::self, location::self.location, age_class::renter_3room_age_map.keys[rnd_choice(renter_3room_age_map.values)], education::renter_3room_education_map.keys[rnd_choice(renter_3room_education_map.values)], income_class::renter_3room_income_map.keys[rnd_choice(renter_3room_income_map.values)], old_new::"old"];
			create renter number: flats_4room with:
			[flat_rooms::4, my_building::self.building_name, my_building_agent::self, location::self.location, age_class::renter_4room_age_map.keys[rnd_choice(renter_4room_age_map.values)], education::renter_4room_education_map.keys[rnd_choice(renter_4room_education_map.values)], income_class::renter_4room_income_map.keys[rnd_choice(renter_4room_income_map.values)], old_new::"old"];
			create renter number: flats_5room with: [flat_rooms::5, my_building::self.building_name, my_building_agent::self, location::self.location, old_new::"old"];
			PP_ID_WBS <- 1;
			if belegungsbindung < 1 {
				rent_frei_bestand <- ((rent - (belegungsbindung * rent_WBS)) / (1 - belegungsbindung)) with_precision 2;
			}

			renter_total <- renter where (each.my_building = self.building_name);
			renter_1room <- renter where (each.my_building = self.building_name and each.flat_rooms = 1);
			renter_2room <- renter where (each.my_building = self.building_name and each.flat_rooms = 2);
			renter_3room <- renter where (each.my_building = self.building_name and each.flat_rooms = 3);
			renter_4room <- renter where (each.my_building = self.building_name and each.flat_rooms = 4);
			ask renter where (each.my_building = self.building_name) {
				rent_category <- "frei";
				contract_duration_years <- rnd(0, 5);
				contract_cycle <- 5;
				rent <- myself.rent_frei_bestand;
			}

			ask (belegungsbindung * length(renter_total)) among (renter where (each.my_building = self.building_name)) {
				rent_category <- "WBS";
				contract_duration_years <- rnd(0, 5);
				contract_cycle <- 5;
				rent <- myself.rent_WBS;
			}

			ask (fluctuation * length(renter_total)) among (renter where (each.my_building = self.building_name)) {
				contract_duration_years <- 0;
			}

			renter_WBS <- renter where (each.my_building = self.building_name and each.rent_category = "WBS");
			renter_frei <- renter where (each.my_building = self.building_name and each.rent_category = "frei");
		}

		ask renter {
			if (age_class = "18-29") {
				self.age <- rnd(18, 29);
			}

			if (age_class = "30-39") {
				self.age <- rnd(30, 39);
			}

			if (age_class = "40-49") {
				self.age <- rnd(40, 49);
			}

			if (age_class = "50-64") {
				self.age <- rnd(50, 64);
			}

			if (age_class = "> 80") {
				self.age <- rnd(80, 102);
			}

			if (age_class = nil) {
				self.age <- 39;
			}

			if (income_class = "< 500") {
				self.income <- rnd(450.0, 499.99) with_precision 2;
			}

			if (income_class = "500-999") {
				self.income <- rnd(500.0, 999.99) with_precision 2;
			}

			if (income_class = "1000-1249") {
				self.income <- rnd(1000.0, 1249.99) with_precision 2;
			}

			if (income_class = "1250-1499") {
				self.income <- rnd(1250.0, 1499.99) with_precision 2;
			}

			if (income_class = "1500-1749") {
				self.income <- rnd(1500.0, 1749.99) with_precision 2;
			}

			if (income_class = "1750-1999") {
				self.income <- rnd(1750.0, 1999.99) with_precision 2;
			}

			if (income_class = "2000-2249") {
				self.income <- rnd(2000.0, 2249.99) with_precision 2;
			}

			if (income_class = "2250-2499") {
				self.income <- rnd(2250.0, 2499.99) with_precision 2;
			}

			if (income_class = "2500-2749") {
				self.income <- rnd(2500.0, 2749.99) with_precision 2;
			}

			if (income_class = "2750-2999") {
				self.income <- rnd(2750.0, 2999.99) with_precision 2;
			}

			if (income_class = "3000-3499") {
				self.income <- rnd(3000.0, 3499.99) with_precision 2;
			}

			if (income_class = "3500-3999") {
				self.income <- rnd(1250.0, 1499.99) with_precision 2;
			}

			square_meter <- 25.0 + flat_rooms * 15;
		}

		create map_button_start number: 1 with: [button_name::string("Start"), location::{world.shape.width * 0.75, world.shape.height * 0.9}];
		create map_button_start number: 1 with: [button_name::string("Stop"), location::{world.shape.width * 0.75, world.shape.height * 0.99}];
		create map_button_start number: 1 with: [button_name::string("Energieverbrauch"), location::{world.shape.width * 0.9, world.shape.height * 0.3}];
		create map_button_start number: 1 with: [button_name::string("Barrierearm"), location::{world.shape.width * 0.9, world.shape.height * 0.4}];
		create map_button_start number: 1 with: [button_name::string("Sanierungsstatus"), location::{world.shape.width * 0.9, world.shape.height * 0.2}];
		create map_button_start number: 1 with: [button_name::string("Eigentumsstruktur"), location::{world.shape.width * 0.9, world.shape.height * 0.1}, active::true];
		create map_button_start number: 1 with: [button_name::string("Lagegunst"), location::{world.shape.width * 0.9, world.shape.height * 0.9}, active::false];
		create map_button_start number: 1 with: [button_name::string("Übersicht"), location::{world.shape.width * 0.9, world.shape.height * 0.99}, active::false];
		ask buildings {
			if (building_name = "Falkenhorst  14") {
				barrierearm_building <- 1;
			}

			if (building_name = "Schilfhof  20") {
				barrierearm_building <- 1;
			}

		}

		ask renter {
			if self.age > 45 {
				if self.flat_rooms > 1 {
					household_type <- "EC";
				}

				if self.flat_rooms < 3 {
					household_type <- "ES";
				}

			}

			if self.age <= 45 {
				if self.flat_rooms = 5 {
					household_type <- "F";
				}

				if self.flat_rooms = 4 {
					household_type <- any(["F", "FS"]);
					write self.household_type;
				}

				if self.flat_rooms = 3 {
					household_type <- any(["F", "FS", "SPF", "YC"]);
					write self.household_type;
				}

				if self.flat_rooms = 2 {
					household_type <- any(["YC", "SPF", "FS"]);
					write self.household_type;
				}

				if self.flat_rooms = 1 {
					household_type <- any(["YS", "SPF"]);
					write self.household_type;
				}

			}

			if household_type = any(["F", "FS", "SPF", "YC", "YS"]) {
				if flip(0.25) {
					barrierearm <- 1;
				}

			}

			if household_type = "ES" {
				if flip(0.5) {
					barrierearm <- 1;
				}

			}

			if household_type = "EC" {
				if flip(0.75) {
					barrierearm <- 1;
				}

			}

		}

		//Pool apartment seeker
		do create_renters_interested;

		// set household-specific "survival" time
		ask renter where (each.seeking = false) {
			survival_time <- household_type_survival_time_map[self.household_type];
		}

		ask buildings {
		//do calculate_public_parking_lots;
			do calculate_own_parking_lots;
		}

		do calculate_attractivity;
	}
	//###########################################
	//###########################################
	//End of Init Section
	action lets_construct {
		construction_permit <- true;
		write "permit";
	}

	action construct_building {
		if construction_permit = true {
			create buildings number: 1 from: shape_neubau with:
			[building_height::float(get("objekthoeh")), description::nil, building_name::"Neubau", name:: "Neubau", flats_1room::flats_1room_new, flats_2room::flats_2room_new, flats_3room::flats_3room_new, flats_4room::flats_4room_new, flats_5room::flats_5room_new, flats_total::nil, property_of::"ProPotsdam", state_refurbishment::"saniert", barrierearm_building::1, rent::nil, year_of_refurbishment_start::nil, year_of_refurbishment_end::nil, fluctuation::nil, belegungsbindung::wbs_new, rent_WBS::nil, energy_consumption_ref::nil, energy_consumption_act::0.5, EGschwelle::nil, school::nil, edu_bool::nil, shop_bool::nil]
			{
				flats_total <- flats_1room_new + flats_2room_new + flats_3room_new + flats_4room_new + flats_5room_new;

				//rent <- ((rent_wbs * renter_wbs) + (rent_neu * renter_frei)) / renter_total
				color_state_refurbishment <- state_refurbishment = "saniert" ? #green : (state_refurbishment = "teilsaniert" ? #yellow : (state_refurbishment = "unsaniert" ?
				#red : (state_refurbishment = "under_construction" ? #darkviolet : #blue)));
				color_property_of <- property_of = "pbg eG" ? #yellow : (property_of = "DtWohnen" ? #darkred : (property_of = "BVA" ? #gamared : (property_of = "BVB" ?
				#wheat : (property_of = "HVEichsfeld" ? #yellowgreen : (property_of = "Talis" ? #forestgreen : (property_of = "ProPotsdam" ? #cornflowerblue : (property_of = "PWG1956 eG" ?
				#darkviolet : (property_of = "WBGKarlMarx" ? #gamablue : (property_of = "Infra / KIS" ? #dimgrey : (property_of = "Gewerbe" ? #lightgrey : #orange))))))))));
				color_barrierearm <- barrierearm_building = 1 ? #yellow : (EGschwelle = 1 ? #darkorange : #red);
				self.location <- #user_location;
				if energy_consumption_act > 0.49 and energy_consumption_act < 0.6 {
					add (self) to: energ_5;
				}

				if energy_consumption_act > 0.59 and energy_consumption_act < 0.7 {
					add (self) to: energ_6;
				}

				if energy_consumption_act > 0.69 and energy_consumption_act < 0.8 {
					add (self) to: energ_7;
				}

				if energy_consumption_act > 0.79 and energy_consumption_act < 0.9 {
					add (self) to: energ_8;
				}

				if energy_consumption_act > 0.89 and energy_consumption_act < 1.0 {
					add (self) to: energ_9;
				}

				if energy_consumption_act >= 1.0 {
					add (self) to: energ_1;
					write energ_1;
				}

			}

			write "built";
			construction_permit <- false;
		}

	}

	action do_show_my_parking_lots {
		ask parking_lot {
			show_parking_lots <- false;
		}

		ask buildings closest_to #user_location {
			do show_my_parking_lots;
		}

	}

	action calculate_attractivity {
		ask buildings where (each.property_of = "ProPotsdam" or each.property_of = "pbg eG" or each.property_of = "PWG1956 eG" or each.property_of = "WBGKarlMarx") {
			self.attractivity_YS <- 0.0;
			self.attractivity_YC <- 0.0;
			self.attractivity_ES <- 0.0;
			self.attractivity_EC <- 0.0;
			self.attractivity_F <- 0.0;
			self.attractivity_SPF <- 0.0;
			self.attractivity_FS <- 0.0;
			create vis_distance_school number: 1 with: [location::self.location];
			if edu_vis = true {
				ask buildings where (each.edu_bool = 1) overlapping (circle(distance_school) at_location self.location) {
					ask myself {
						self.attractivity_YS <- self.attractivity_YS + 0.012;
						self.attractivity_YC <- self.attractivity_YC + 0.024;
						self.attractivity_ES <- self.attractivity_ES + 0.011;
						self.attractivity_EC <- self.attractivity_EC + 0.010;
						self.attractivity_F <- self.attractivity_F + 0.055;
						self.attractivity_SPF <- self.attractivity_SPF + 0.074;
						self.attractivity_FS <- self.attractivity_FS + 0.013;
					}

				}

			}

			if shop_vis = true {
				ask buildings where (each.shop_bool = 1) overlapping (circle(500 #m) at_location self.location) {
					ask myself {
						self.attractivity_YS <- self.attractivity_YS + 0.024;
						self.attractivity_YC <- self.attractivity_YC + 0.024;
						self.attractivity_ES <- self.attractivity_ES + 0.045;
						self.attractivity_EC <- self.attractivity_EC + 0.041;
						self.attractivity_F <- self.attractivity_F + 0.027;
						self.attractivity_SPF <- self.attractivity_SPF + 0.028;
						self.attractivity_FS <- self.attractivity_FS + 0.026;
					}

				}

			}

			if pt_near_vis = true {
				ask POI where (each.pt_bool = 1) overlapping (circle(500 #m) at_location self.location) {
					ask myself {
						self.attractivity_YS <- self.attractivity_YS + 0.024;
						self.attractivity_YC <- self.attractivity_YC + 0.024;
						self.attractivity_ES <- self.attractivity_ES + 0.045;
						self.attractivity_EC <- self.attractivity_EC + 0.041;
						self.attractivity_F <- self.attractivity_F + 0.027;
						self.attractivity_SPF <- self.attractivity_SPF + 0.028;
						self.attractivity_FS <- self.attractivity_FS + 0.026;
					}

				}

			}

			if pt_far_vis = true {
				ask POI where (each.pt_bool = 1) overlapping (circle(1000 #m) at_location self.location) {
					ask myself {
						self.attractivity_YS <- self.attractivity_YS + 0.060;
						self.attractivity_YC <- self.attractivity_YC + 0.046;
						self.attractivity_ES <- self.attractivity_ES + 0.011;
						self.attractivity_EC <- self.attractivity_EC + 0.010;
						self.attractivity_F <- self.attractivity_F + 0.018;
						self.attractivity_SPF <- self.attractivity_SPF + 0.018;
						self.attractivity_FS <- self.attractivity_FS + 0.064;
					}

				}

			}

			attractivity_total <- nil;
			add self.attractivity_YS to: attractivity_total;
			add self.attractivity_YC to: attractivity_total;
			add self.attractivity_ES to: attractivity_total;
			add self.attractivity_EC to: attractivity_total;
			add self.attractivity_F to: attractivity_total;
			add self.attractivity_SPF to: attractivity_total;
			add self.attractivity_FS to: attractivity_total;
			self.attractivity_perhh_map <-
			[self.attractivity_YS::"YS", self.attractivity_YC::"YC", self.attractivity_ES::"ES", self.attractivity_EC::"EC", self.attractivity_F::"F", self.attractivity_SPF::"SPF", self.attractivity_FS::"FS"];
			write self.attractivity_perhh_map;
			self.hh_perattractivity_map <- reverse(self.attractivity_perhh_map);
			self.hh_type_max_attr <- attractivity_perhh_map max_of each;

			//write attractivity_total;
			attractivity_max <- attractivity_total max_of each;
			//write attractivity_max;
		}

	}

	action create_renters_interested {
		create renter number: number_interested_renters - length(renter where (each.seeking = true and each.flat_rooms = 1)) with:
		[flat_rooms::1, age_class::renter_1room_age_map.keys[rnd_choice(renter_1room_age_map.values)], education::renter_1room_education_map.keys[rnd_choice(renter_1room_education_map.values)], income_class::renter_1room_income_map.keys[rnd_choice(renter_1room_income_map.values)], old_new::"new", seeking::true];
		create renter number: number_interested_renters - length(renter where (each.seeking = true and each.flat_rooms = 2)) with:
		[flat_rooms::2, age_class::renter_2room_age_map.keys[rnd_choice(renter_2room_age_map.values)], education::renter_2room_education_map.keys[rnd_choice(renter_2room_education_map.values)], income_class::renter_2room_income_map.keys[rnd_choice(renter_2room_income_map.values)], old_new::"new", seeking::true];
		create renter number: number_interested_renters - length(renter where (each.seeking = true and each.flat_rooms = 3)) with:
		[flat_rooms::3, age_class::renter_3room_age_map.keys[rnd_choice(renter_3room_age_map.values)], education::renter_3room_education_map.keys[rnd_choice(renter_3room_education_map.values)], income_class::renter_3room_income_map.keys[rnd_choice(renter_3room_income_map.values)], old_new::"new", seeking::true];
		create renter number: number_interested_renters - length(renter where (each.seeking = true and each.flat_rooms = 4)) with:
		[flat_rooms::4, age_class::renter_4room_age_map.keys[rnd_choice(renter_4room_age_map.values)], education::renter_4room_education_map.keys[rnd_choice(renter_4room_education_map.values)], income_class::renter_4room_income_map.keys[rnd_choice(renter_4room_income_map.values)], old_new::"new", seeking::true];
		create renter number: number_interested_renters - length(renter where (each.seeking = true and each.flat_rooms = 5)) with:
		[flat_rooms::5, age_class::renter_4room_age_map.keys[rnd_choice(renter_4room_age_map.values)], education::renter_4room_education_map.keys[rnd_choice(renter_4room_education_map.values)], income_class::renter_4room_income_map.keys[rnd_choice(renter_4room_income_map.values)], old_new::"new", seeking::true];

		//Classification of renter in household types based on age and roomnumber of flat
		ask renter where (each.seeking = true) {
			available <- true;
			if self.age > 45 {
				if self.flat_rooms > 1 {
					household_type <- "EC";
				}

				if self.flat_rooms < 3 {
					household_type <- "ES";
				}

			}

			if self.age <= 45 {
				if self.flat_rooms = 5 {
					household_type <- "F";
				}

				if self.flat_rooms = 4 {
					household_type <- any(["F", "FS"]);
					write self.household_type;
				}

				if self.flat_rooms = 3 {
					household_type <- any(["F", "FS", "SPF", "YC"]);
					write self.household_type;
				}

				if self.flat_rooms = 2 {
					household_type <- any(["YC", "SPF", "FS"]);
					write self.household_type;
				}

				if self.flat_rooms = 1 {
					household_type <- any(["YS", "SPF"]);
					write self.household_type;
				}

			}

			//Attribute flat in low-barrier building required
			if household_type = any(["F", "FS", "SPF", "YC", "YS"]) {
				if flip(0.25) {
					barrierearm <- 1;
				}

			}

			if household_type = any(["ES"]) {
				if flip(0.5) {
					barrierearm <- 1;
				}

			}

			if household_type = any(["EC"]) {
				if flip(0.75) {
					barrierearm <- 1;
				}

			}

		}

	}

	reflex refill_renters_interested {
		if month = 3 {
			do create_renters_interested;
			write "refill completed";
			write length(renter where (each.seeking = true));
			ask renter where (each.seeking = true) {
				write self.flat_rooms;
			}

			offers <- nil;
			write offers;
		}

	}

	reflex rent_history_schlaatz {
		if month = 3 and start_time = true {
			list<float> rent_history_schlaatz_temp;
			loop times: 1 {
				ask buildings {
					if self.rent != nil {
						add (rent) to: rent_history_schlaatz_temp;
					}

				}

				add (mean(rent_history_schlaatz_temp)) to: rent_history_schlaatz_PP;
				rent_schlaatz_PP <- (mean(rent_history_schlaatz_temp) with_precision 2);
			}

		}

	}

	reflex energy_history_schlaatz {
		if month = 12 and start_time = true {
			list<float> energy_history_schlaatz_temp;
			loop times: 1 {
				ask buildings {
					if property_of = "ProPotsdam" {
						add (energy_saved * 100) to: energy_history_schlaatz_temp;
					}

				}

				add (mean(energy_history_schlaatz_temp)) to: energy_history_schlaatz_PP;
				energy_saved_schlaatz_PP <- ((mean(energy_history_schlaatz_temp) with_precision 2));
			}

		}

	}

	action map_button_start_stop {
		ask map_button_start {
			active <- false;
		}

		ask map_button_start overlapping (rectangle(500, 200) at_location #user_location) {
			if (self.button_name = "Start") {
				active <- true;
				start_time <- true;
			}

			if (self.button_name = "Stop") {
				ask map_button_start {
					active <- false;
				}

				active <- true;
				start_time <- false;
			}

			if (self.button_name = "Energieverbrauch") {
				active <- true;
				energieverbrauch <- true;
				sanierungsstatus <- false;
				eigentum <- false;
				barrierearm <- false;
				attractivity <- false;
			}

			if (self.button_name = "Sanierungszeiten") {
				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- true;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- false;
			}

			if (self.button_name = "Barrierearm") {
				active <- true;
				energieverbrauch <- false;
				sanierungszeiten <- false;
				barrierearm <- true;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- false;
			}

			if (self.button_name = "Sanierungsstatus") {
				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- true;
				eigentum <- false;
				attractivity <- false;
			}

			if (self.button_name = "Eigentumsstruktur") {
				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- true;
				attractivity <- false;
			}

			if (self.button_name = "Übersicht") {
				active <- true;
				ask map_button_start where (each.button_name != "Lagegunst" and each.button_name != "Start" and each.button_name != "Stop" and each.button_name != "Übersicht") {
					do die;
				}

				create map_button_start number: 1 with: [button_name::string("Energieverbrauch"), location::{world.shape.width * 0.9, world.shape.height * 0.5}];
				create map_button_start number: 1 with: [button_name::string("Barrierearm"), location::{world.shape.width * 0.9, world.shape.height * 0.6}];
				create map_button_start number: 1 with: [button_name::string("Sanierungsstatus"), location::{world.shape.width * 0.9, world.shape.height * 0.4}];
				create map_button_start number: 1 with: [button_name::string("Eigentumsstruktur"), location::{world.shape.width * 0.9, world.shape.height * 0.3}, active::true];
				ask map_button_start where (each.button_name = "Eigentumsstruktur") {
					active <- true;
				}

				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- true;
				attractivity <- false;
			}

			if (self.button_name = "Lagegunst") {
				active <- true;
				ask world {
					do calculate_attractivity;
				}

				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				ask map_button_start where (each.button_name != "Lagegunst" and each.button_name != "Start" and each.button_name != "Stop" and each.button_name != "Übersicht") {
					do die;
				}

				create map_button_start number: 1 with: [button_name::string("Junge Singles"), location::{world.shape.width * 0.9, world.shape.height * 0.1}];
				create map_button_start number: 1 with: [button_name::string("Junge Lebensgemeinschaft"), location::{world.shape.width * 0.9, world.shape.height * 0.2}];
				create map_button_start number: 1 with: [button_name::string("Ältere Singles"), location::{world.shape.width * 0.9, world.shape.height * 0.3}];
				create map_button_start number: 1 with: [button_name::string("Ältere Lebensgemeinschaft"), location::{world.shape.width * 0.9, world.shape.height * 0.4}, active::true];
				create map_button_start number: 1 with: [button_name::string("Familien, alleinerziehend"), location::{world.shape.width * 0.9, world.shape.height * 0.5}, active::false];
				create map_button_start number: 1 with: [button_name::string("Familien"), location::{world.shape.width * 0.9, world.shape.height * 0.6}, active::false];
				create map_button_start number: 1 with: [button_name::string("Wohngemeinschaften"), location::{world.shape.width * 0.9, world.shape.height * 0.7}, active::false];
			}

			if (self.button_name = "Junge Singles") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "YS";
			}

			if (self.button_name = "Ältere Singles") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "ES";
			}

			if (self.button_name = "Junge Lebensgemeinschaft") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "YC";
			}

			if (self.button_name = "Ältere Lebensgemeinschaft") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "EC";
			}

			if (self.button_name = "Familien") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "F";
			}

			if (self.button_name = "Familien, alleinerziehend") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "SPF";
			}

			if (self.button_name = "Wohngemeinschaften") {
				ask map_button_start {
					active <- false;
				}

				ask world {
					do calculate_attractivity;
				}

				active <- true;
				energieverbrauch <- false;
				barrierearm <- false;
				sanierungszeiten <- false;
				sanierungsstatus <- false;
				eigentum <- false;
				attractivity <- true;
				attractivity_map <- "FS";
			}

		}

	}

	reflex stop_simulation {
		if year = 2035 {
			start_time <- false;
			ask map_button_start where (each.button_name = "Stop") {
				active <- true;
			}

		}

	}

	reflex count_time {
		if (start_time = true) {
			month <- month + 1;
			month_2 <- month_2 + 1;
			if (month = 13) {
				year <- year + 1;
				month <- 1;
			}

			if month_2 = 25 {
				year_2 <- year_2 + 2;
				month_2 <- 1;
			}

		}

	}

	species renter {
		string cluster;
		map cluster_prob;
		int flat_rooms;
		float rent;
		string rent_category;
		float rent_flat;
		int age;
		string age_class;
		float income;
		string income_class;
		float household_income;
		float willingness_to_pay <- 0.2;
		string education;
		string my_building;
		int contract_cycle;
		float square_meter;
		string old_new <- "old";
		int barrierearm <- 0;
		bool asked <- false;
		bool precarious <- false;
		int contract_duration_years;
		bool move_out <- false;
		bool move_out_selected <- false;
		bool seeking;
		bool hard_criteria_match <- false;
		bool available;
		list<renter> interested;
		string household_type;
		int survival_time;
		renter successor;
		buildings my_building_agent;
		float attractivity_offer;

		aspect default {
			draw circle(20) color: #yellow;
		}

		reflex count_contract_duration_7 {
			if contract_cycle = 7 {
				if start_time = true and month = 12 {
					contract_duration_years <- contract_duration_years + 1;
				}

				if contract_duration_years = 8 and month = 1 {
					contract_duration_years <- 0;
					old_new <- "old";
				}

			}

		}

		reflex count_contract_duration_5 {
			if contract_cycle = 5 {
				if start_time = true and month = 12 {
					contract_duration_years <- contract_duration_years + 1;
				}

				if contract_duration_years = 6 and month = 1 {
					contract_duration_years <- 0;
					old_new <- "old";
				}

			}

		}

		reflex count_survival_time {
			if contract_duration_years >= self.survival_time {
				move_out <- true;
				//	write "wanna get outta here";

			}

		}

		reflex calculate_rent_flat {
			rent_flat <- (rent * square_meter) with_precision 2;
		}

		action update_willingness_to_pay {
			willingness_to_pay <- household_type = "YS" ? wp_YS : (household_type = "YC" ? wp_YC : (household_type = "ES" ? wp_ES : (household_type = "EC" ? wp_EC : (household_type = "F" ?
			wp_F : (household_type = "SPF" ? wp_SPF : wp_FS)))));
		}

		reflex check_offers {
			if consider_soft_criteria = true {
				if month = 6 and self.seeking = true {
					ask renter where (each.move_out_selected = true) {
						if (flat_rooms = self.flat_rooms) and (rent_flat < (self.income * self.willingness_to_pay)) and ((barrierearm_building of (my_building_agent)) <= self.barrierearm) {
							add (myself) to: self.interested;
						}

					}

				}

			} else {
				if month = 6 and self.seeking = true {
					ask renter where (each.move_out_selected = true) {
						if (flat_rooms = self.flat_rooms) and (rent_flat < (self.income * self.willingness_to_pay)) and ((barrierearm_building of (my_building_agent)) <= self.barrierearm) {
							add (myself) to: self.interested;
						}

					}

				}

			}

		}

		reflex move_out {
			if move_out_selected = true and month = 8 {
				if (self.interested where (each.available = true and each.household_type = (hh_type_max_attr of self.my_building_agent))) != nil {
					ask one_of(self.interested where (each.available = true and each.household_type = (hh_type_max_attr of self.my_building_agent))) {
						my_building_agent <- myself.my_building_agent;
						my_building <- myself.my_building;
						location <- myself.location;
						old_new <- "new";
						rent_category <- myself.rent_category;
						rent <- myself.rent * (1 + rent_increase_new);
						contract_duration_years <- 0;
						contract_cycle <- self.contract_cycle;
						survival_time <- household_type_survival_time_map[self.household_type];
						write self.name + "moved in for " + myself.name + self.my_building;
						seeking <- false;
						move_out <- false;
						myself.successor <- self;
						available <- false;
						add (self) to: neuvermietung;
						add (self) to: neuvermietung_building of myself.my_building_agent;
						ask myself {
							do die;
						}

					}

				} else {
					ask one_of(self.interested where (each.available = true)) {
						my_building_agent <- myself.my_building_agent;
						my_building <- myself.my_building;
						location <- myself.location;
						old_new <- "new";
						rent_category <- myself.rent_category;
						rent <- myself.rent * (1 + rent_increase_new);
						contract_duration_years <- 0;
						contract_cycle <- self.contract_cycle;
						survival_time <- household_type_survival_time_map[self.household_type];
						write self.name + "moved in for " + myself.name + self.my_building;
						seeking <- false;
						move_out <- false;
						myself.successor <- self;
						available <- false;
						add (self) to: neuvermietung;
						add (self) to: neuvermietung_building of myself.my_building_agent;
						ask myself {
							do die;
						}

					}

				}

			}

		}

	}

	species POI {
		string name;
		int pt_bool;
		string pt_type;

		aspect default {
			if pt_far_vis = true or pt_near_vis = true {
				draw circle(10 #m) color: #yellow;
			}

		}

	}

	species buildings {
		int PP_ID_WBS <- 0;
		int buildingID;
		string building_name;
		string property_of;
		string description;
		int flats_total;
		int flats_2room;
		int flats_3room;
		int flats_4room;
		int flats_5room;
		int flats_1room;
		list renter_1room;
		list renter_2room;
		list renter_3room;
		list renter_4room;
		list renter_total;
		list renter_left;
		list renter_new;
		list renter_WBS;
		list renter_WBS40;
		list renter_frei;
		list renter_precarious;
		list renter_YS;
		list renter_YC;
		list renter_ES;
		list renter_EC;
		list renter_F;
		list renter_SPF;
		list renter_FS;
		list renter_history_YS;
		list renter_history_YC;
		list renter_history_ES;
		list renter_history_EC;
		list renter_history_F;
		list renter_history_SPF;
		list renter_history_FS;
		list neuvermietung_building;
		float bestand;
		float neuverm;
		float belegungsbindung;
		float belegungsbindung_wbs40;
		float rent_frei_neu;
		float rent_WBS;
		float rent;
		float rent_frei_bestand;
		float rent_wbs40;
		list rent_history_frei;
		list rent_history_frei_bestand;
		list rent_history_frei_neu;
		list rent_history;
		list rent_history_neu;
		list rent_history_wbs;
		list rent_history_wbs40;
		list energy_consumption_history;
		float fluctuation;
		int year_of_refurbishment_start;
		int year_of_refurbishment_end;
		bool under_construction <- false;
		string state_refurbishment;
		bool refurbished <- false;
		float energy_consumption_act;
		float energy_consumption_init <- 1.0;
		float energy_consumption_ref;
		string school;
		float building_height;
		string street;
		int housenumber;
		int barrierearm_building <- 0;
		int EGschwelle <- 0;
		rgb color_nonrefurbished <- #orange;
		rgb color_under_construction <- #darkviolet;
		rgb color_refurbished <- #cornflowerblue;
		rgb color_other_property <- #darkgrey;
		rgb color_state_refurbishment;
		rgb color_property_of;
		rgb color_barrierearm;
		string address <- self.street + " " + self.housenumber;
		float energy_saved;
		int edu_bool;
		int shop_bool;
		float attractivity_YS;
		float attractivity_YC;
		float attractivity_ES;
		float attractivity_EC;
		float attractivity_F;
		float attractivity_SPF;
		float attractivity_FS;
		map<float, string> attractivity_perhh_map;
		map<string, map> hh_perattractivity_map;
		string hh_type_max_attr;
		list my_parking_lots;
		float ratio_parkinglots_flats;
		float ratio_parkinglots_flats_required;
		renter example_renter_YS;
		renter example_renter_YC;
		renter example_renter_ES;
		renter example_renter_EC;
		renter example_renter_F;
		renter example_renter_SPF;
		renter example_renter_FS;

		aspect new {
			if sanierungsstatus = true {
				draw shape depth: building_height color: color_state_refurbishment border: #grey;
				//draw (string(property_of)) at: self.location + { 0, 0, 20 } color: # white font: font("FHP Sun Office", 10, # bold);
			}

			if eigentum = true {
				draw shape depth: building_height color: color_property_of border: #grey;
			}

			if barrierearm = true {
				if (property_of = "ProPotsdam" or property_of = "pbg eG" or property_of = "PWG1956 eG" or property_of = "WBGKarlMarx") {
					draw shape depth: building_height color: color_barrierearm border: #grey;
				} else {
					draw shape depth: building_height color: #grey border: #grey;
				}

			}

			if (energieverbrauch = true and property_of = "ProPotsdam") {
				draw shape depth: building_height color: rgb(255 * energy_consumption_act, 100 * 1 / energy_consumption_act, 100 * energy_consumption_act) border: #grey;
			}

			if (energieverbrauch = true and property_of != "ProPotsdam") {
				draw shape depth: building_height color: #grey border: #grey;
			}

			if attractivity = true {
				if edu_bool = 1 and edu_vis = true {
					draw shape depth: building_height color: #orange border: #grey;
				} else {
					if shop_bool = 1 and shop_vis = true {
						draw shape depth: building_height color: #orangered border: #grey;
					} else {
						if attractivity_map = "YS" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 255 * (self.attractivity_YS / attractivity_max) ^ 2, 255, (self.attractivity_YS / attractivity_max) + 0.3) border: #grey;
						}

						if attractivity_map = "YC" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_YC / attractivity_max) ^ 2, 255, (self.attractivity_YC / attractivity_max) + 0.3) border: #grey;
						}

						if attractivity_map = "ES" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_ES / attractivity_max) ^ 2, 255, (self.attractivity_ES / attractivity_max) + 0.3) border: #grey;
						}

						if attractivity_map = "EC" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_EC / attractivity_max) ^ 2, 255, (self.attractivity_EC / attractivity_max) + 0.3) border: #grey;
						}

						if attractivity_map = "F" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_F / attractivity_max) ^ 2, 255, (self.attractivity_F / attractivity_max) + 0.3) border: #grey;
						}

						if attractivity_map = "SPF" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_SPF / attractivity_max) ^ 2, 255, (self.attractivity_SPF / attractivity_max) + 0.3) border:
							#grey;
						}

						if attractivity_map = "FS" and (self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx") {
							draw shape depth: building_height color: rgb(120, 220 * (self.attractivity_FS / attractivity_max) ^ 2, 255, (self.attractivity_FS / attractivity_max) + 0.3) border: #grey;
						}

					}

				}

			}

		}

		action show_my_parking_lots {
			ask parking_lot where (each.my_building = self) {
				show_parking_lots <- true;
			}

		}

		action calculate_own_parking_lots {
			ask parking_lot where (each.assigned_building = self.building_name and each.assigned_building != nil) {
				assigned <- true;
				self.my_building <- myself;
				add self to: myself.my_parking_lots;
			}

			ratio_parkinglots_flats <- (length(self.my_parking_lots) / flats_total) with_precision 2;
		}

		action calculate_public_parking_lots {
			ask parking_lot overlapping (circle(sp_distance) at_location self.location) {
				if self.assigned = false {
					assigned <- true;
					self.my_building <- myself;
					add self to: myself.my_parking_lots;
				}

			}

			ratio_parkinglots_flats <- (length(self.my_parking_lots) / flats_total) with_precision 2;
		}

		reflex update_renter_example {
			if month = 1 or month = 3 or month = 5 or month = 7 or month = 9 or month = 11 {
				example_renter_YS <- one_of(renter where (each.household_type = "YS" and each.seeking = false and each.my_building_agent = self));
				example_renter_YC <- one_of(renter where (each.household_type = "YC" and each.seeking = false and each.my_building_agent = self));
				example_renter_ES <- one_of(renter where (each.household_type = "ES" and each.seeking = false and each.my_building_agent = self));
				example_renter_EC <- one_of(renter where (each.household_type = "EC" and each.seeking = false and each.my_building_agent = self));
				example_renter_F <- one_of(renter where (each.household_type = "F" and each.seeking = false and each.my_building_agent = self));
				example_renter_SPF <- one_of(renter where (each.household_type = "SPF" and each.seeking = false and each.my_building_agent = self));
				example_renter_FS <- one_of(renter where (each.household_type = "FS" and each.seeking = false and each.my_building_agent = self));
			}

		}

		reflex increase_rent {
			if refurbished = false {
				ask renter where (each.my_building = self.building_name and each.rent_category = "frei") {
					if self.contract_duration_years = 4 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.05)) * (1 - inflation) with_precision 2;
					}

					if self.contract_duration_years = 5 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.02)) * (1 - inflation) with_precision 2;
					}

				}

				ask renter where (each.my_building = self.building_name and each.rent_category = "WBS") {
					if self.contract_duration_years = 4 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.05)) * (1 - inflation) with_precision 2;
					}

					if self.contract_duration_years = 5 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.02)) * (1 - inflation) with_precision 2;
					}

				}

			}

			if refurbished = true {
				ask renter where (each.my_building = self.building_name) {
					if self.contract_duration_years = 4 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.06)) * (1 - inflation) with_precision 2;
					}

					if self.contract_duration_years = 5 and month = 12 {
						self.rent <- (self.rent + (self.rent * 0.03)) * (1 - inflation) with_precision 2;
					}

				}

			}

			if (month = 12 and start_time = true) {
				loop times: 1 {
					list<float> rent_wbs_temp;
					list<float> rent_wbs40_temp;
					list<float> rent_frei_bestand_temp;
					list<float> rent_frei_neu_temp;
					list<float> rent_gesamt_temp;
					write "increased";
					ask renter where (each.my_building = self.building_name and each.rent_category = "WBS") {
						add (rent) to: rent_wbs_temp;
					}

					ask renter where (each.my_building = self.building_name and each.rent_category = "WBS40+") {
						add (rent) to: rent_wbs40_temp;
					}

					ask renter where (each.my_building = self.building_name and each.rent_category = "frei" and each.old_new = "old") {
						add (rent) to: rent_frei_bestand_temp;
					}

					ask renter where (each.my_building = self.building_name and each.rent_category = "frei" and each.old_new = "new") {
						add (rent) to: rent_frei_neu_temp;
					}

					ask renter where (each.my_building = self.building_name) {
						add (rent) to: rent_gesamt_temp;
					}

					add (mean(rent_wbs_temp)) to: rent_history_wbs;
					add (mean(rent_wbs40_temp)) to: rent_history_wbs40;
					add (mean(rent_frei_bestand_temp)) to: rent_history_frei_bestand;
					add (mean(rent_frei_neu_temp)) to: rent_history_frei_neu;
					add (mean(rent_gesamt_temp)) to: rent_history;
					self.rent_WBS <- (mean(rent_wbs_temp)) with_precision 2;
					self.rent_wbs40 <- (mean(rent_wbs40_temp)) with_precision 2;
					self.rent_frei_bestand <- (mean(rent_frei_bestand_temp)) with_precision 2;
					self.rent_frei_neu <- (mean(rent_frei_neu_temp)) with_precision 2;
					self.rent <- (mean(rent_gesamt_temp)) with_precision 2;
					rent_wbs_temp <- nil;
					rent_wbs40_temp <- nil;
					rent_frei_bestand_temp <- nil;
					rent_frei_neu_temp <- nil;
					rent_gesamt_temp <- nil;
				}

			}

		}

		reflex refurbishment {
			color_state_refurbishment <- state_refurbishment = "saniert" ? #green : (state_refurbishment = "teilsaniert" ? #yellow : (state_refurbishment = "unsaniert" ?
			#red : (state_refurbishment = "under_construction" ? #darkviolet : #blue)));
			if (year = year_of_refurbishment_start) {
				under_construction <- true;
				state_refurbishment <- "under_construction";
				color_state_refurbishment <- #darkviolet;
			}

			if (year = year_of_refurbishment_end and month = 12) {
				loop times: 1 {
					ask (length(renter_total) * 0.375) among (renter where (each.my_building = self.building_name and each.asked = false)) {
						rent_category <- "WBS";
						contract_duration_years <- 0;
						contract_cycle <- 5;
						rent <- 4.6;
						asked <- true;
					}

					ask (length(renter_total) * 0.375) among (renter where (each.my_building = self.building_name and each.asked = false)) {
						rent_category <- "WBS40+";
						contract_duration_years <- 0;
						contract_cycle <- 5;
						rent <- 5.5;
						asked <- true;
						old_new <- "new";
					}

					ask (length(renter_total) * 0.125) among (renter where (each.my_building = self.building_name and each.asked = false)) {
						rent_category <- "frei";
						contract_duration_years <- 0;
						contract_cycle <- 5;
						old_new <- "old";
						rent <- 6.0;
						asked <- true;
					}

					ask (length(renter_total) * 0.125) among (renter where (each.my_building = self.building_name and each.asked = false)) {
						rent_category <- "frei";
						contract_duration_years <- 0;
						contract_cycle <- 5;
						old_new <- "new";
						rent <- 7.0;
						asked <- true;
					}

					under_construction <- false;
					refurbished <- true;
					state_refurbishment <- "saniert";
					energy_consumption_act <- energy_consumption_ref;
					if energy_consumption_act > 0.49 and energy_consumption_act < 0.6 {
						add (self) to: energ_5;
					}

					if energy_consumption_act > 0.59 and energy_consumption_act < 0.7 {
						add (self) to: energ_6;
					}

					if energy_consumption_act > 0.69 and energy_consumption_act < 0.8 {
						add (self) to: energ_7;
					}

					if energy_consumption_act > 0.79 and energy_consumption_act < 0.9 {
						add (self) to: energ_8;
					}

					if energy_consumption_act > 0.89 and energy_consumption_act < 1.0 {
						add (self) to: energ_9;
					}

					if energy_consumption_act >= 1.0 {
						add (self) to: energ_1;
						write energ_1;
					}

				}

			}

		}

		reflex energy_history {
			if (month = 11 and start_time = true) {
				energy_saved <- energy_saved + (1 - energy_consumption_act);
				add (energy_saved * 100) to: energy_consumption_history;
			}

		}

		reflex renter_fluctuation {
			if self.property_of = "ProPotsdam" or self.property_of = "pbg eG" or self.property_of = "PWG1956 eG" or self.property_of = "WBGKarlMarx" {
				if (month = 5) {
					start_time <- false;
					if fluctuation_mode = "Fluktuationsrate 2019" {
						if ((self.fluctuation / 2) * length(self.renter_total)) > length(renter where (each.my_building = self.building_name and each.move_out = true)) {
							ask (renter where (each.my_building = self.building_name and each.move_out = true)) + ((((self.fluctuation / 2) * length(self.renter_total) - length(renter where
							(each.my_building = self.building_name and each.move_out = true)))) among (renter where (each.my_building = self.building_name and each.move_out = false))) {
								add (self) to: offers;
								move_out_selected <- true;
							}

						}

						if ((self.fluctuation / 2) * length(self.renter_total)) <= length(renter where (each.my_building = self.building_name and each.move_out = true)) {
							ask ((self.fluctuation / 2) * length(self.renter_total)) among (renter where (each.my_building = self.building_name and each.move_out = true)) {
								add (self) to: offers;
								move_out_selected <- true;
							}

						}

					}

					if fluctuation_mode = "Fluktuation nach Haushaltstypen" {
						ask (renter where (each.my_building = self.building_name and each.move_out = true)) {
							add (self) to: offers;
							move_out_selected <- true;
						}

					}

					start_time <- true;
				}

			}

		}

		reflex update_renter_total {
			if month = 2 {
				loop times: 1 {
					renter_total <- renter where (each.my_building_agent = self);
					renter_new <- renter where (each.my_building_agent = self and each.old_new = "new");
					//renter_precarious <- renter where (each.my_building = self.building_name and each.precarious = true);
					renter_WBS <- renter where (each.my_building_agent = self and each.rent_category = "WBS");
					renter_frei <- renter where (each.my_building_agent = self and each.rent_category = "frei");
					renter_WBS40 <- renter where (each.my_building_agent = self and each.rent_category = "WBS40+");
					renter_YS <- renter where (each.my_building_agent = self and each.household_type = "YS");
					renter_YC <- renter where (each.my_building_agent = self and each.household_type = "YC");
					renter_ES <- renter where (each.my_building_agent = self and each.household_type = "ES");
					renter_EC <- renter where (each.my_building_agent = self and each.household_type = "EC");
					renter_F <- renter where (each.my_building_agent = self and each.household_type = "F");
					renter_SPF <- renter where (each.my_building_agent = self and each.household_type = "SPF");
					renter_FS <- renter where (each.my_building_agent = self and each.household_type = "FS");
					write "renter updated";
				}

			}

			do update_ratio_parkinglots_flats_required;
		}

		action update_ratio_parkinglots_flats_required {
			ratio_parkinglots_flats_required <-
			((length(renter_YS) * sp_YS + length(renter_YC) * sp_YC + length(renter_ES) * sp_ES + length(renter_ES) + length(renter_EC) * sp_EC + length(renter_F) * sp_F + length(renter_SPF) * sp_SPF + length(renter_FS) * wp_FS) / length(renter_total))
			with_precision 2;
		}

		reflex update_renter_history {
			if month = 3 {
				add length(renter_YS) to: renter_history_YS;
				add length(renter_YC) to: renter_history_YC;
				add length(renter_ES) to: renter_history_ES;
				add length(renter_EC) to: renter_history_EC;
				add length(renter_F) to: renter_history_F;
				add length(renter_SPF) to: renter_history_SPF;
				add length(renter_FS) to: renter_history_FS;
			}

		}

	}

	species vis_distance_school {

		aspect default {
			draw circle(distance_school) color: rgb(66, 221, 255, 0.4);
		}

	}

	species parking_lot {
		rgb color_property;
		string nutzung;
		buildings my_building;
		bool assigned <- false;
		bool show_parking_lots;
		string assigned_building;

		aspect default {
			if eigentum = true {
				draw shape color: color_property;
			} else {
				draw shape color: #darkgrey border: #grey;
			}

			if self.assigned = true and self.show_parking_lots = true {
				draw shape color: #darkgrey border: #grey;
				draw polyline([self.location, my_building]) color: #white;
			}

		}

	}

	species elevator {
	}

	aspect default {
		draw circle(2000) color: #cornflowerblue border: #white;
	}

	species liegenschaft {
		int liegenschaftsnummer;
	}

	species stadtbezirke {
		string name;

		aspect default {
			draw shape color: #green border: #yellow;
		}

	}

	species map_button_start {
		string button_name;
		bool active;

		aspect default {
			if (active = false) {
				draw string(button_name) color: #grey font: font("FHP Sun Office", 30, #plain);
			} else {
				draw string(button_name) color: #white font: font("FHP Sun Office", 30, #bold);
			}

		}

	}

}

experiment potsdam {
	user_command neubau action: lets_construct category: "Neubau";
	output {
		display "map" type: opengl background: #black refresh: every(1 #cycle) autosave: false {
			image background_schlaatz;
			species buildings aspect: new;
			species stadtbezirke;
			species map_button_start;
			species parking_lot;
			species POI;
			//species vis_distance_school;
			event [mouse_down] action: map_button_start_stop;
			event [mouse_down] action: do_show_my_parking_lots;
			event [mouse_down] action: construct_building;
			//event [mouse_down] action: calculate_attractivity;
			//species renter;
			graphics "Adresse" {
			//draw (string(building_name of (buildings closest_to #user_location))) at: (#user_location + {0, 0, 20}) color: #cornflowerblue font: font("FHP Sun Office", 30, #bold);
			}

			graphics "Zeit" {
				draw (string(year) + "	/  " + string(month)) at: {world.shape.width * -0.3, world.shape.height * 0.95} color: #white font: font("FHP Sun Office", 40, #bold);
			}

			graphics "Adresse" {
				draw (string(building_name of (buildings closest_to #user_location))) at: (location of (buildings closest_to #user_location)) + {0, 0, 20 #m} color: #white font:
				font("FHP Sun Office", 25, #plain);
			}

			graphics "Eigentum" {
				draw (string(property_of of (buildings closest_to #user_location))) at: (location of (buildings closest_to #user_location)) + {0, 40 #m, 20 #m} color: #white font:
				font("FHP Sun Office", 25, #plain);
			}

			graphics "Übersicht" {
				if eigentum = true {
					draw ("pbg eG") at: {world.shape.width * (-0.3), world.shape.height * 0.1} color: #yellow font: font("FHP Sun Office", 30, #plain);
					draw ("Deutsche Wohnen") at: {world.shape.width * -0.3, world.shape.height * 0.15} color: #darkred font: font("FHP Sun Office", 30, #plain);
					draw ("privat BVA") at: {world.shape.width * -0.3, world.shape.height * 0.2} color: #gamared font: font("FHP Sun Office", 30, #plain);
					draw ("privat BVB") at: {world.shape.width * -0.3, world.shape.height * 0.25} color: #wheat font: font("FHP Sun Office", 30, #plain);
					draw ("Hausv. Eichsfeld") at: {world.shape.width * -0.3, world.shape.height * 0.3} color: #yellowgreen font: font("FHP Sun Office", 30, #plain);
					draw ("Talis") at: {world.shape.width * -0.3, world.shape.height * 0.35} color: #forestgreen font: font("FHP Sun Office", 30, #plain);
					draw ("ProPotsdam") at: {world.shape.width * -0.3, world.shape.height * 0.4} color: #cornflowerblue font: font("FHP Sun Office", 30, #plain);
					draw ("PWG 1956 eG") at: {world.shape.width * -0.3, world.shape.height * 0.45} color: #darkviolet font: font("FHP Sun Office", 30, #plain);
					draw ("WBG Karl Marx eG") at: {world.shape.width * -0.3, world.shape.height * 0.5} color: #gamablue font: font("FHP Sun Office", 30, #plain);
					draw ("Infrastruktur / KIS") at: {world.shape.width * -0.3, world.shape.height * 0.55} color: #dimgrey font: font("FHP Sun Office", 30, #plain);
					draw ("Gewerbe") at: {world.shape.width * -0.3, world.shape.height * 0.6} color: #lightgrey font: font("FHP Sun Office", 30, #plain);
					draw ("Sonstige") at: {world.shape.width * -0.3, world.shape.height * 0.65} color: #orange font: font("FHP Sun Office", 30, #plain);
					draw ("ca. 120 Stellplätze ProPotsdam") at: {world.shape.width * -0.3, world.shape.height * 0.75} color: #cornflowerblue font: font("FHP Sun Office", 20, #plain);
					draw ("ca. ") + (string(length(list(parking_lot where (each.nutzung = "infra"))))) + " SP öffentlich" at: {world.shape.width * -0.3, world.shape.height * 0.78} color: #grey
					font: font("FHP Sun Office", 20, #plain);
					draw ("ca. ") + (string(length(list(parking_lot where (each.nutzung = "gewerbe"))))) + " SP gewerbl." at: {world.shape.width * -0.3, world.shape.height * 0.81} color: #white
					font: font("FHP Sun Office", 20, #plain);
					draw ("ca. ") + (string(length(list(parking_lot where (each.nutzung = "karlmarx"))))) + " SP WBG Karl Marx" at: {world.shape.width * -0.3, world.shape.height * 0.84} color:
					#gamablue font: font("FHP Sun Office", 20, #plain);
				}

				if sanierungsstatus = true {
					draw "Bestand gesamt:" at: {world.shape.width * -0.3, world.shape.height * 0.05} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.state_refurbishment = "saniert"))))) + " sanierte Gebäude" at: {world.shape.width * -0.3, world.shape.height * 0.1} color:
					#green font: font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.state_refurbishment = "teilsaniert"))))) + " teilsanierte Gebäude" at: {world.shape.width * -0.3, world.shape.height * 0.15}
					color: #yellow font: font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.state_refurbishment = "unsaniert"))))) + " unsanierte Gebäude" at: {world.shape.width * -0.3, world.shape.height * 0.2} color:
					#red font: font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.under_construction = true))))) + " Gebäude in Sanierung" at: {world.shape.width * -0.3, world.shape.height * 0.25} color:
					#darkviolet font: font("FHP Sun Office", 30, #plain);
					draw "keine Angabe" at: {world.shape.width * -0.3, world.shape.height * 0.3} color: #blue font: font("FHP Sun Office", 30, #plain);
				}

				if barrierearm = true {
					draw "Bestand AK Stadtspuren" at: {world.shape.width * -0.3, world.shape.height * 0.05} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.barrierearm_building = 1))))) + "  Gebäude mit Aufzug" at: {world.shape.width * -0.3, world.shape.height * 0.1} color: #yellow
					font: font("FHP Sun Office", 30, #plain);
					//draw (string(length(list(buildings where (each.barrierearm_building = 0 and (each.property_of = "ProPotsdam" or each.property_of = "pbg eG" or
					//each.property_of = "PWG 1956 eG" or each.property_of = "WBGKarlMarx")))))) + "  Gebäude ohne Aufzug" at: {world.shape.width * -0.3, world.shape.height * 0.2} color: #red
					draw (string("12  Gebäude ohne Aufzug")) at: {world.shape.width * -0.3, world.shape.height * 0.2} color: #red font: font("FHP Sun Office", 30, #plain);
					//draw (string(length(list(buildings where (each.EGschwelle = 1 and each.barrierearm_building = 0))))) + "  Gebäude EG schwellenlos" at:
					//{world.shape.width * -0.3, world.shape.height * 0.15} color: #darkorange font: font("FHP Sun Office", 30, #plain);
					draw (string("4 Gebäude EG schwellenlos")) at: {world.shape.width * -0.3, world.shape.height * 0.15} color: #darkorange font: font("FHP Sun Office", 30, #plain);
				}

			}

			graphics "Übersicht Energie (fiktiv)" {
				if energieverbrauch = true {
					draw "Bestand ProPotsdam:" at: {world.shape.width * -0.3, world.shape.height * 0.05} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_5))) + "  Gebäude mit 40-50%" at: {world.shape.width * -0.3, world.shape.height * 0.1} color: rgb(255 * 0.5, 100 * 1 / 0.5, 100 * 0.5) font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_6))) + "  Gebäude mit 30-40%" at: {world.shape.width * -0.3, world.shape.height * 0.15} color: rgb(255 * 0.6, 100 * 1 / 0.6, 100 * 0.6) font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_7))) + "  Gebäude mit 20-30%" at: {world.shape.width * -0.3, world.shape.height * 0.2} color: rgb(255 * 0.7, 100 * 1 / 0.7, 100 * 0.7) font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_8))) + "  Gebäude mit 10-20%" at: {world.shape.width * -0.3, world.shape.height * 0.25} color: rgb(255 * 0.8, 100 * 1 / 0.8, 100 * 0.8) font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_9))) + "  Gebäude mit 01-10% " at: {world.shape.width * -0.3, world.shape.height * 0.3} color: rgb(255 * 0.9, 100 * 1 / 0.9, 100 * 0.9) font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(energ_9))) + "verr. Wärmeverbr. ab 2020" at: {world.shape.width * -0.3, world.shape.height * 0.4} color: #lightgrey font:
					font("FHP Sun Office", 30, #plain);
					draw (string(length(list(buildings where (each.energy_consumption_act = 1.0))))) + "  Gebäude mit 0% " at: {world.shape.width * -0.3, world.shape.height * 0.35} color:
					rgb(255 * 1, 100 * 1 / 1, 100 * 1) font: font("FHP Sun Office", 30, #plain);
					draw (string(energy_saved_schlaatz_PP)) + "  % des Wärmeverbrauchs" at: {world.shape.width * -0.3, world.shape.height * 0.6} color: #cornflowerblue font:
					font("FHP Sun Office", 30, #plain);
					draw (string(energy_saved_schlaatz_PP)) + "     in 2020 eingespart" at: {world.shape.width * -0.3, world.shape.height * 0.65} color: #cornflowerblue font:
					font("FHP Sun Office", 30, #plain);
				}

			}

			graphics "Attraktivitäts-Mapping" {
				if attractivity = true {
					draw ("Attraktivität nach Lage für") at: {world.shape.width * -0.3, world.shape.height * 0.4} color: #white font: font("FHP Sun Office", 30, #plain);
					if attractivity_map = "YS" {
						draw ("Junge Singles") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "YC" {
						draw ("Junge Lebensgemeinschaft") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "ES" {
						draw ("Ältere Singles") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "EC" {
						draw ("Ältere Lebensgemeinschaft") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "F" {
						draw ("Familien") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "SPF" {
						draw ("Familien, alleinerziehend") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

					if attractivity_map = "FS" {
						draw ("Wohngemeinschaften") at: {world.shape.width * -0.3, world.shape.height * 0.43} color: #white font: font("FHP Sun Office", 30, #bold);
					}

				}

			}

		}

		display "Gebäudeinfo Classic" type: opengl background: #black refresh: every(1 #cycle) autosave: false {
		//			chart name: "Mietbelastungsquote >33% (NKM)" position: {0.7, 0.1} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain)
		//			series_label_position: legend {
		//				data "Bewohner mit MBQ über 33%" value: length(renter_precarious of (buildings where (each.buildingID != 0) closest_to #user_location)) color: #grey;
		//				data "Bewohner mit MBQ unter 33%" value: length(renter_total of (buildings where (each.buildingID != 0) closest_to #user_location)) - length(renter_precarious of (buildings
		//				where (each.buildingID != 0) closest_to #user_location)) + 1 color: #blue;
		//			}
		//			chart name: "Verhältnis alte / neue Mieter seit 2020" position: {0.5, 0.001} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain)
		//			{
		//				data "Bewohner neu" value: length(renter_new of (buildings closest_to #user_location)) color: #white;
		//				data "Bewohner alt" value: (length(renter_total of (buildings closest_to #user_location)) - length(renter_new of (buildings where (each.property_of = "ProPotsdam") closest_to
		//				#user_location))) color: #cornflowerblue;
		//			}
			chart name: "Verhältnis Haushaltstypen (fiktiv)" position: {0.5, 0.001} size: 0.5 type: pie style: ring background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
				data "Junge Singles" value: length((renter_YS of (buildings closest_to #user_location))) color: #white;
				data "Junge Lebensgemeinschaft" value: length((renter_YC of (buildings closest_to #user_location))) color: #orange;
				data "Ältere Singles" value: length((renter_ES of (buildings closest_to #user_location))) color: #cornflowerblue;
				data "Ältere Lebensgemeinschaft" value: length((renter_EC of (buildings closest_to #user_location))) color: #cyan;
				data "Familien" value: length((renter_F of (buildings closest_to #user_location))) color: #red;
				data "Familien, alleinerziehend" value: length((renter_SPF of (buildings closest_to #user_location))) color: #violet;
				data "Wohngemeinschaften" value: length((renter_FS of (buildings closest_to #user_location))) color: #darkblue;
			}

			chart name: "Verhältnis Belegungsbindung (fiktiv)" position: {0.5, 0.5} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
				data "mit WBS" value: (length(renter_WBS of (buildings closest_to #user_location))) color: #white;
				data "mit WBS40+" value: (length(renter_WBS40 of (buildings closest_to #user_location))) color: #darkgrey;
				data "frei vermietbar" value: (length(renter_frei of (buildings closest_to #user_location))) color: #cornflowerblue;
			}

			//			chart name: "Verhältnis Mieter auszug" position: {0.5, 0.5} size: 0.5 type: pie style: ring background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
			//				data "Bewohner auszugswillig" value: length(renter where (each.move_out_selected = true and each.seeking = false)) color: #white;
			//				data "Bewohner bleiben" value: length(renter where (each.move_out_selected = false and each.seeking = false)) color: #cornflowerblue;
			//			}
			//length(renter_total)) among (renter where (each.my_building = self.building_name)
			graphics "Adresse" {
				draw (string(building_name of (buildings closest_to #user_location))) at: {0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
				draw (string(property_of of (buildings closest_to #user_location))) at: {0, world.shape.height * 0.05} color: #white font: font("FHP Sun Office", 40, #plain);
				draw (string(flats_total of (buildings closest_to #user_location)) + " Wohnungen gesamt") at: {0, world.shape.height * 0.2} color: #white font:
				font("FHP Sun Office", 40, #plain);
				draw (string(flats_1room of (buildings closest_to #user_location)) + "   1-Raum Wohnungen") at: {0, world.shape.height * 0.25} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_2room of (buildings closest_to #user_location)) + "   2-Raum Wohnungen") at: {0, world.shape.height * 0.3} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_3room of (buildings closest_to #user_location)) + "   3-Raum Wohnungen") at: {0, world.shape.height * 0.35} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_4room of (buildings closest_to #user_location)) + "   4-Raum Wohnungen") at: {0, world.shape.height * 0.4} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_5room of (buildings closest_to #user_location)) + "   5-Raum Wohnungen") at: {0, world.shape.height * 0.45} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(length(my_parking_lots of (buildings closest_to #user_location))) + "   Stellplätze (Beta)") at: {0, world.shape.height * 0.5} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw ("Stellplatzschlüssel Ist (Beta):   " + ratio_parkinglots_flats of (buildings closest_to #user_location)) at: {0, world.shape.height * 0.55} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw ("Stellplatzschlüssel Soll (Beta):   " + ratio_parkinglots_flats_required of (buildings closest_to #user_location)) at: {0, world.shape.height * 0.6} color: #white font:
				font("FHP Sun Office", 30, #plain);
				//draw ((string(length(neuvermietung_building of (buildings closest_to #user_location)))) + "   Neuvermietungen im Gebäude,  " + string(length(neuvermietung)) + "   Neuvermietungen gesamt") at: { 0, world.shape.height * 0.6 } color: # white font: font("FHP Sun Office", 30, # plain);
							draw "Mieten (fiktiv):" at: {0, world.shape.height * 0.7} color: #white font: font("FHP Sun Office", 20, #italic);
			
				draw (string(rent of (buildings closest_to #user_location)) + " €/qm (gesamt)") at: {0, world.shape.height * 0.75} color: #white font: font("FHP Sun Office", 40, #plain);
				draw (string(rent_WBS of (buildings closest_to #user_location)) + " €/qm (WBS)") at: {0, world.shape.height * 0.8} color: #white font: font("FHP Sun Office", 30, #plain);
				draw (string(rent_wbs40 of (buildings closest_to #user_location)) + " €/qm (WBS40+)") at: {0, world.shape.height * 0.85} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(rent_frei_bestand of (buildings closest_to #user_location)) + " €/qm (freiverm. Bestandsm.)") at: {0, world.shape.height * 0.9} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(rent_frei_neu of (buildings closest_to #user_location)) + " €/qm (freiverm. Neuverm.)") at: {0, world.shape.height * 0.95} color: #white font:
				font("FHP Sun Office", 30, #plain);
				//draw (string(rent_schlaatz_PP) + " €/qm (PP gesamt Schlaatz)") at: {0, world.shape.height * 1.0} color: #white font: font("FHP Sun Office", 30, #plain);
			}

			chart name: "Mietentwicklung (fiktiv)" position: {2000, 0.001} size: 0.5 type: series background: #black x_tick_unit: year y_range: [4.5, 12.0] x_label: "jährlich ab 2020"
			y_tick_values_visible: true color: #white title_font: font("FHP Sun Office", 50, #plain) {
				data "Mietentwicklung WBS " value: rent_history_wbs of (buildings closest_to #user_location) color: #white;
				data "Mietentwicklung WBS40+" value: rent_history_wbs40 of (buildings closest_to #user_location) color: #darkgrey;
				data "Mietentwicklung freivermietbar Bestandsmieter" value: rent_history_frei_bestand of (buildings closest_to #user_location) color: #orange;
				data "Mietentwicklung freivermietbar Neuvermietung" value: rent_history_frei_neu of (buildings closest_to #user_location) color: #darkviolet;
				data "Mietentwicklung gesamt" value: rent_history of (buildings closest_to #user_location) color: #darkred;
			}

			chart name: "Wärmeeinsparung relativ seit 2020 (fiktiv)" position: {2000, 0.5} size: 0.5 type: series background: #black x_tick_unit: year x_label: "prozentual jährlich ab 2020" color:
			#white title_font: font("FHP Sun Office", 50, #plain) {
				data "Wärmeeinsparung ggü. 2020 seit 2020 Gebäude" value: energy_consumption_history of (buildings closest_to #user_location) color: #orange;
				data "Wärmeeinsparung ggü. 2020 seit 2020 PP" value: energy_history_schlaatz_PP color: #cornflowerblue;
			}

			//			graphics "Zeit" {
			//				draw ("Jahr	" + string(year) + "	  	Monat	" + string(month)) at: {0, world.shape.height * 0.99} color: #white font: font("FHP Sun Office", 40, #plain);
			//			}

		}

		display "Haushaltstypen" type: opengl background: #black refresh: every(1 #cycle) autosave: false {
		//			chart name: "Mietbelastungsquote >33% (NKM)" position: {0.7, 0.1} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain)
		//			series_label_position: legend {
		//				data "Bewohner mit MBQ über 33%" value: length(renter_precarious of (buildings where (each.buildingID != 0) closest_to #user_location)) color: #grey;
		//				data "Bewohner mit MBQ unter 33%" value: length(renter_total of (buildings where (each.buildingID != 0) closest_to #user_location)) - length(renter_precarious of (buildings
		//				where (each.buildingID != 0) closest_to #user_location)) + 1 color: #blue;
		//			}
		//			chart name: "Verhältnis alte / neue Mieter seit 2020" position: {0.5, 0.001} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain)
		//			{
		//				data "Bewohner neu" value: length(renter_new of (buildings closest_to #user_location)) color: #white;
		//				data "Bewohner alt" value: (length(renter_total of (buildings closest_to #user_location)) - length(renter_new of (buildings where (each.property_of = "ProPotsdam") closest_to
		//				#user_location))) color: #cornflowerblue;
		//			}
			chart name: "Gewichtung Lagegunst" position: {0.7, 0.01} size: 0.8 type: pie style: ring background: #black color: #white axes: #white title_font: ("FHP Sun Office", 40, #plain)
			tick_line_color: #white y_range: [0.0, 0.1] x_tick_values_visible: true {
				data "ÖPNV <500m" value: attr_weight_pt_u500[attractivity_map] color: #yellow;
				data "ÖPNV >500m" value: attr_weight_pt_o500[attractivity_map] color: #yellow;
				data "Schule" value: attr_weight_school[attractivity_map] color: #darkorange;
				data "Einkaufen <500m" value: attr_weight_shop_u500[attractivity_map] color: #orangered;
			}

			graphics "Gewählter Haushaltstyp" {
				if attractivity_map = "YS" {
					draw ("Junge Singles") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_YS) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_YS of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_YS of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_YS of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_YS of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_YS of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_YS of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_YS of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_YS of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_YS of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_YS of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "YC" {
					draw ("Junge Lebensgemeinschaft") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_YC) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_YC of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_YC of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_YC of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_YC of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_YC of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_YC of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_YC of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_YC of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_YC of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_YC of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "ES" {
					draw ("Ältere Singles") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_ES) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_ES of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_ES of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_ES of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_ES of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_ES of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_ES of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_ES of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_ES of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_ES of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_ES of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "EC" {
					draw ("Ältere Lebensgemeinschaft") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_EC) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_EC of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_EC of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_EC of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_EC of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_EC of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_EC of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_EC of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_EC of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_EC of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_EC of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "F" {
					draw ("Familien") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_F) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_F of (buildings closest_to #user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.425}
					color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_F of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_F of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_F of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_F of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_F of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_F of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_F of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_F of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_F of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "SPF" {
					draw ("Familien, alleinerziehend") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_SPF) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_SPF of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_SPF of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_SPF of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_SPF of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_SPF of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_SPF of (buildings
					closest_to #user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_SPF of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_SPF of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_SPF of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at:
					{world.shape.width * 0.00, world.shape.height * 0.525} color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_SPF of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				if attractivity_map = "FS" {
					draw ("Wohngemeinschaften") at: {world.shape.width * 0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
					draw ("Zahlungsbereitschaft Miete:  " + wp_FS) at: {world.shape.width * 0, world.shape.height * 0.25} color: #white font: font("FHP Sun Office", 30, #plain);
					draw (string("Wohngebäude: ") + string(my_building of (example_renter_FS of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.425} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Raumanzahl:   " + string(flat_rooms of (example_renter_FS of (buildings closest_to #user_location))) + " |  " + string((rent of (example_renter_FS of (buildings
					closest_to #user_location))) with_precision 2) + " €/qm NKM" + " |  " + string(rent_category of (example_renter_FS of (buildings closest_to #user_location)))) at:
					{world.shape.width * 0.00, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(square_meter of (example_renter_FS of (buildings closest_to #user_location))) + " qm" + "  |  " + string(rent_flat of (example_renter_FS of (buildings closest_to
					#user_location))) + " € NKM") at: {world.shape.width * 0.00, world.shape.height * 0.475} color: #white font: font("FHP Sun Office", 25, #plain);
					draw ("Alter:  " + string(age of (example_renter_FS of (buildings closest_to #user_location))) + "  |  " + string(education of (example_renter_FS of (buildings closest_to
					#user_location)))) at: {world.shape.width * 0.00, world.shape.height * 0.5} color: #white font: font("FHP Sun Office", 25, #plain);
					draw (string(income of (example_renter_FS of (buildings closest_to #user_location))) + " € monatl. Nettoeinkommen") at: {world.shape.width * 0.00, world.shape.height * 0.525}
					color: #white font: font("FHP Sun Office", 25, #plain);
					if (barrierearm of (example_renter_FS of (buildings closest_to #user_location)) = 1) {
						draw ("Barrierarme Wohnung erforderlich: ja") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					} else {
						draw ("Barrierarme Wohnung erforderlich: nein") at: {world.shape.width * 0.00, world.shape.height * 0.55} color: #white font: font("FHP Sun Office", 25, #plain);
					}

				}

				draw (string("Altersgruppe:  ") + hht_map_age[attractivity_map]) at: {world.shape.width * 0.00, world.shape.height * 0.1} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string("Wohnungstypen:  ") + hht_map_roomsflat[attractivity_map]) at: {world.shape.width * 0.00, world.shape.height * 0.15} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string("Verweildauer in Wohnung:  ") + hht_map_survival_time[attractivity_map]) at: {world.shape.width * 0.00, world.shape.height * 0.2} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string("Beispielmieter:")) at: {world.shape.width * 0.00, world.shape.height * 0.4} color: #white font: font("FHP Sun Office", 30, #plain);
			}

		}

		display "Gebäudeinfo Mieterbewegung" type: opengl background: #black refresh: every(1 #cycle) autosave: false {
			chart name: "Verhältnis Haushaltstypen" position: {0.5, 0.001} size: 0.5 type: pie style: ring background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
				data "Junge Singles" value: length((renter_YS of (buildings closest_to #user_location))) color: #white;
				data "Junge Lebensgemeinschaft" value: length((renter_YC of (buildings closest_to #user_location))) color: #orange;
				data "Ältere Singles" value: length((renter_ES of (buildings closest_to #user_location))) color: #cornflowerblue;
				data "Ältere Lebensgemeinschaften" value: length((renter_EC of (buildings closest_to #user_location))) color: #cyan;
				data "Familien" value: length((renter_F of (buildings closest_to #user_location))) color: #red;
				data "Familien, alleinerziehend " value: length((renter_SPF of (buildings closest_to #user_location))) color: #violet;
				data "Wohngemeinschaften" value: length((renter_FS of (buildings closest_to #user_location))) color: #darkblue;
			}

			//			chart name: "Verhältnis Belegungsbindung" position: {0.5, 0.5} size: 0.5 type: pie background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
			//				data "mit WBS" value: (length(renter_WBS of (buildings closest_to #user_location))) color: #white;
			//				data "mit WBS40+" value: (length(renter_WBS40 of (buildings closest_to #user_location))) color: #darkgrey;
			//				data "frei vermietbar" value: (length(renter_frei of (buildings closest_to #user_location))) color: #cornflowerblue;
			//			}
			chart name: "Fluktuation" position: {0.5, 0.5} size: 0.5 type: pie style: ring background: #black color: #white title_font: font("FHP Sun Office", 30, #plain) {
				data "Bewohner auszugswillig" value: length(renter where (each.move_out_selected = true and each.seeking = false and each.my_building_agent = buildings closest_to
				#user_location)) color: #white;
				data "Bewohner wollen bleiben" value: length(renter where (each.move_out_selected = false and each.seeking = false and each.my_building_agent = buildings closest_to
				#user_location)) color: #cornflowerblue;
			}

			graphics "Adresse" {
				draw (string(building_name of (buildings closest_to #user_location))) at: {0, world.shape.height * 0.001} color: #white font: font("FHP Sun Office", 40, #plain);
				draw (string(property_of of (buildings closest_to #user_location))) at: {0, world.shape.height * 0.05} color: #white font: font("FHP Sun Office", 40, #plain);
				//				draw (string(flats_total of (buildings closest_to # user_location)) + " Wohnungen gesamt") at: { 0, world.shape.height * 0.2 } color: # white font:
				//				font("FHP Sun Office", 40, # plain);
				draw (string(flats_1room of (buildings closest_to #user_location)) + "   1-Raum Wohnungen") at: {0, world.shape.height * 0.1} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_2room of (buildings closest_to #user_location)) + "   2-Raum Wohnungen") at: {0, world.shape.height * 0.15} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_3room of (buildings closest_to #user_location)) + "   3-Raum Wohnungen") at: {0, world.shape.height * 0.2} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_4room of (buildings closest_to #user_location)) + "   4-Raum Wohnungen") at: {0, world.shape.height * 0.25} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw (string(flats_5room of (buildings closest_to #user_location)) + "   5-Raum Wohnungen") at: {0, world.shape.height * 0.3} color: #white font:
				font("FHP Sun Office", 30, #plain);
				draw ((string(length(neuvermietung_building of (buildings closest_to #user_location)))) + "   Neuvermietung(en) im Gebäude") at: {0, world.shape.height * 0.4} color: #white
				font: font("FHP Sun Office", 30, #plain);
				draw (string(length(neuvermietung)) + "   Neuvermietungen gesamt") at: {0, world.shape.height * 0.45} color: #white font: font("FHP Sun Office", 30, #plain);
			}

			chart name: "Mietentwicklung (fiktiv)" position: {2000, 0.001} size: 0.5 type: series background: #black x_tick_unit: year y_range: [4.5, 12.0] x_label: "jährlich ab 2020"
			y_tick_values_visible: true color: #white title_font: font("FHP Sun Office", 50, #plain) {
				data "Mietentwicklung WBS" value: rent_history_wbs of (buildings closest_to #user_location) color: #white;
				data "Mietentwicklung WBS40+" value: rent_history_wbs40 of (buildings closest_to #user_location) color: #darkgrey;
				data "Mietentwicklung freivermietbar Bestandsmieter" value: rent_history_frei_bestand of (buildings closest_to #user_location) color: #orange;
				data "Mietentwicklung freivermietbar Neuvermietung" value: rent_history_frei_neu of (buildings closest_to #user_location) color: #darkviolet;
				data "Mietentwicklung gesamt" value: rent_history of (buildings closest_to #user_location) color: #darkred;
			}

			chart name: "Veränderung Mieterstruktur" position: {2000, 0.5} size: 0.5 type: series background: #black x_tick_unit: year x_label: "prozentual jährlich ab 2020" color: #white
			title_font: font("FHP Sun Office", 50, #plain) {
				data "Junge Singles " value: renter_history_YS of (buildings closest_to #user_location) color: #white;
				data "Junge Lebensgemeinschaft" value: renter_history_YC of (buildings closest_to #user_location) color: #orange;
				data "Ältere Singles" value: renter_history_ES of (buildings closest_to #user_location) color: #cornflowerblue;
				data "Ältere Lebensgmeinschaft" value: renter_history_EC of (buildings closest_to #user_location) color: #cyan;
				data "Familien" value: renter_history_F of (buildings closest_to #user_location) color: #red;
				data "Familien, alleinerziehend" value: renter_history_SPF of (buildings closest_to #user_location) color: #violet;
				data "Wohngemeinschaften" value: renter_history_FS of (buildings closest_to #user_location) color: #darkblue;
			}

			chart name: "Attraktivität nach Haushaltstyp" position: {0, 0.5} size: 0.5 type: histogram background: #black color: #white title_font: font("FHP Sun Office", 50, #plain) {
				data "Junge Singles " value: attractivity_YS of (buildings closest_to #user_location) color: #white;
				data "Junge Lebensgemeinschaft" value: attractivity_YC of (buildings closest_to #user_location) color: #orange;
				data "Ältere Singles" value: attractivity_ES of (buildings closest_to #user_location) color: #cornflowerblue;
				data "Ältere Lebensgmeinschaft" value: attractivity_EC of (buildings closest_to #user_location) color: #cyan;
				data "Familien" value: attractivity_F of (buildings closest_to #user_location) color: #red;
				data "Familien, alleinerziehend" value: attractivity_SPF of (buildings closest_to #user_location) color: #violet;
				data "Wohngemeinschaften" value: attractivity_FS of (buildings closest_to #user_location) color: #darkblue;
			}

		}

	}

}