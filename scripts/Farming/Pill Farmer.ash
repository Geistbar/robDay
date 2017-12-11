// pill_farmer.ash
// Automatically farms pills from Deep Inside Grimace
// notify "weatherboy";
import "zlib.ash";

setvar("Pill_Farmer_mapmode", "use");
// Uses only exiting maps.  If you want to farm for maps, type in the cli 
// zlib Pill_Farmer_mapmode = "farm";

setvar("Pill_Farmer_goal", "both");
// Other values for goal are "booze" or "food" or "both" if you just want one or the other
// zlib Pill_Farmer_goal = "booze"; or zlib Pill_Farmer_goal = "food";

string mapmode = vars["Pill_Farmer_mapmode"];  
string setgoal = vars["Pill_Farmer_goal"];  

location grimace = $location[Domed City of Grimacia];
item sheltermap = $item[map to safety shelter grimace prime];

string hatch = "choice.php?pwd&whichchoice=536&option=1";
string drink = "choice.php?pwd&whichchoice=536&option=1";
string  door = "choice.php?pwd&whichchoice=536&option=2";
string foodgoal = "choice.php?pwd&whichchoice=536&option=1";
string boozgoal = "choice.php?pwd&whichchoice=536&option=2";

void pillfarm() {
	if (mapmode == "farm") {
		while ( item_amount(sheltermap) == 0 ) adventure(1, grimace); 
	}
	if ( item_amount(sheltermap) > 0 ) {
		visit_url("inv_use.php?pwd&which=3&whichitem=5172");
		visit_url(hatch); visit_url(drink); visit_url(door);
		if ( setgoal == "food" ) visit_url(foodgoal);
		else if ( setgoal == "booze" ) visit_url(boozgoal);
		else if ( setgoal == "both" ) { 
			if ( get_property("lastgoal") == "booze" ) {
				visit_url(foodgoal); 
				set_property("lastgoal","food");
			} else if ( get_property("lastgoal") == "food" || get_property("lastgoal") =="" ) {
				visit_url(boozgoal);
				set_property("lastgoal","booze");
			}
		}
	} else { print("You are out of maps.","blue"); exit; }
}

void main() {
	if ( have_effect( $effect[transpondent] ) < 1 ) {
		if ( item_amount( $item[transporter transponder] ) < 1 ) {
			print("You need a Transporter to do this. Use the Li'l Xenomorph to get some.","blue");
			exit;
		}
		use( 1, $item[transporter transponder] );
	}
	if ( mapmode == "farm" ) {
		cli_execute("trigger lose_effect, transpondent, use 1 transporter transponder");
		cli_execute("trigger lose_effect, leash, cast 1 leash");
		cli_execute("trigger lose_effect, empathy, cast 1 empathy");
		cli_execute("trigger lose_effect, phat loot, cast 1 phat loot");
		if (dispensary_available()) {
			cli_execute("trigger lose_effect, heavy petting, use 1 pet-buffing spray");
			cli_execute("trigger lose_effect, peeled eyeballs, use 1 knob goblin eyedrops");
		}
		maximize("items",false);
		use_familiar( best_fam("items") );  // zlib!
		if ( my_familiar() == $familiar[Li'l Xenomorph] ) equip($item[tiny top hat and cane]);
	}
	
	while ( my_adventures() > 0 && have_effect( $effect[transpondent] ) > 0 ) {
		pillfarm();
	}
	if ( my_adventures() == 0 ) abort("out of adventures");
}