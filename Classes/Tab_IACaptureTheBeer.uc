// ====================================================================
//  Class:  XInterface.Tab_IACaptureTheFlag
//  Parent: XInterface.Tab_InstantActionBaseRules
//
//  <Enter a description here>
// ====================================================================

class Tab_IACaptureTheBeer extends Tab_IACaptureTheFlag;

// Configuration
var(CTB) config int		LastBottlesPerCrate;				// GameReplicationInfo
var(CTB) config bool	LastbHealthPickupRestore;		// xPlayer
// PlayerReplicationInfo --
var(CTB) config float LastMaxBeerConsumption;
var(CTB) config float LastfDrinkSpeed;
var(CTB) config float LastfSoberSpeed;
var(CTB) config float LastsmWanderSpeed;
var(CTB) config float LastsmAccel;
// -- PlayerReplicationInfo

var	moNumericEdit	MyBottlesPerCrate;
var moCheckBox		MybHealthPickupRestore;
var moFloatEdit		MyMaxBeerConsumption;
var moFloatEdit		MyfDrinkSpeed;
var moFloatEdit		MyfSoberSpeed;
var moFloatEdit		MysmWanderSpeed;
var moFloatEdit		MysmAccel;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);

	Controls[0].WinHeight = 0.537071; // bg image
	Controls[1].WinHeight = 0.593321; // bg image
	Controls[9].WinTop = 0.273437; // team score
	Controls[10].WinTop = 0.344792; // time limit

	MyBottlesPerCrate = moNumericEdit(Controls[14]);
	MyBottlesPerCrate.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[0];
	MybHealthPickupRestore = moCheckBox(Controls[15]);
	MybHealthPickupRestore.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[1];
	MyMaxBeerConsumption = moFloatEdit(Controls[16]);
	MyMaxBeerConsumption.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[2];
	MyfDrinkSpeed = moFloatEdit(Controls[17]);
	MyfDrinkSpeed.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[3];
	MyfSoberSpeed = moFloatEdit(Controls[18]);
	MyfSoberSpeed.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[4];
	MysmWanderSpeed = moFloatEdit(Controls[19]);
	MysmWanderSpeed.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[5];
	MysmAccel = moFloatEdit(Controls[20]);
	MysmAccel.MyLabel.Caption = class'CTBgame'.default.CTBPropsDisplayText[6];

	MyBottlesPerCrate.SetValue(LastBottlesPerCrate);
	MybHealthPickupRestore.Checked(LastbHealthPickupRestore);
	MyMaxBeerConsumption.SetValue(LastMaxBeerConsumption);
	MyfDrinkSpeed.SetValue(LastfDrinkSpeed);
	MyfSoberSpeed.SetValue(LastfSoberSpeed);
	MysmWanderSpeed.SetValue(LastsmWanderSpeed);
	MysmAccel.SetValue(LastsmAccel);
}

function string Play()
{
	LastBottlesPerCrate = MyBottlesPerCrate.GetValue();
	LastbHealthPickupRestore = MybHealthPickupRestore.IsChecked();
	LastMaxBeerConsumption = MyMaxBeerConsumption.GetValue();
	LastfDrinkSpeed = MyfDrinkSpeed.GetValue();
	LastfSoberSpeed = MyfSoberSpeed.GetValue();
	LastsmWanderSpeed = MysmWanderSpeed.GetValue();
	LastsmAccel = MysmAccel.GetValue();

	SaveConfig();
	return Super.Play()$"?CrateSize="$LastBottlesPerCrate$"?HealthRestore="$LastbHealthPickupRestore$
		"?MaxBeer="$LastMaxBeerConsumption$"?DrinkSpeed="$LastfDrinkSpeed$"?SoberSpeed="$LastfSoberSpeed$
		"?WanderSpeed="$LastsmWanderSpeed$"?WanderAccel="$LastsmAccel;
}

defaultproperties
{
	GoalScoreText="Beer Capture Limit"

	LastGoalScore=72
	// GRI
	LastBottlesPerCrate=24
	// PC
	LastbHealthPickupRestore=true
	// PRI
	LastMaxBeerConsumption=24
	LastfDrinkSpeed=20
	LastfSoberSpeed=60
	LastsmWanderSpeed=500
	LastsmAccel=2.5

	Begin Object class=moNumericEdit Name=IARulesBottlesPerCrate
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.414323
		CaptionWidth=0.7
		MinValue=1
		MaxValue=999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(14)=moNumericEdit'IARulesBottlesPerCrate'

	Begin Object class=moCheckBox Name=IARulesbHealthPickupRestore
		WinWidth=0.400000
		WinHeight=0.040000
		WinLeft=0.047656
		WinTop=0.705989
		Hint=""
		bSquare=true
		ComponentJustification=TXTA_Left
		CaptionWidth=0.9
	End Object
	Controls(15)=moCheckBox'IARulesbHealthPickupRestore'

	Begin Object class=moFloatEdit Name=IARulesMaxBeerConsumption
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.480989
		CaptionWidth=0.7
		MinValue=1
		MaxValue=999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(16)=moFloatEdit'IARulesMaxBeerConsumption'	

	Begin Object class=moFloatEdit Name=IARulesfDrinkSpeed
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.547656
		CaptionWidth=0.7
		MinValue=0
		MaxValue=99999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(17)=moFloatEdit'IARulesfDrinkSpeed'

	Begin Object class=moFloatEdit Name=IARulesfSoberSpeed
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.614322
		CaptionWidth=0.7
		MinValue=0
		MaxValue=99999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(18)=moFloatEdit'IARulesfSoberSpeed'

	Begin Object class=moFloatEdit Name=IARulessmWanderSpeed
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.680989
		CaptionWidth=0.7
		MinValue=0
		MaxValue=99999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(19)=moFloatEdit'IARulessmWanderSpeed'

	Begin Object class=moFloatEdit Name=IARulessmAccel
		WinWidth=0.400000
		WinHeight=0.060000
		WinLeft=0.553906
		WinTop=0.747656
		CaptionWidth=0.7
		MinValue=0
		MaxValue=99999
		ComponentJustification=TXTA_Left
		Hint=""
	End Object
	Controls(20)=moFloatEdit'IARulessmAccel'

}
