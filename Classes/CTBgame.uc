////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Game class
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBgame.uc,v 1.4 2003/10/22 11:14:26 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBgame extends xCTFgame config;

// Configuration
var(CTB) config int		BottlesPerCrate;				// GameReplicationInfo
var(CTB) config bool	bHealthPickupRestore;		// xPlayer
// PlayerReplicationInfo --
var(CTB) config float MaxBeerConsumption;
var(CTB) config float fDrinkSpeed;
var(CTB) config float fSoberSpeed;
var(CTB) config float smWanderSpeed;
var(CTB) config float smAccel;
// -- PlayerReplicationInfo

var localized string CTBPropsDisplayText[7];

event InitGame( string Options, out string Error )
{
	local string InOpt;

	Super.InitGame(Options, Error);

	InOpt = ParseOption( Options, "CrateSize");
	if ( int(InOpt) > 0 )
	{
		BottlesPerCrate = int(InOpt);
	}
	InOpt = ParseOption( Options, "HealthRestore");
	if ( InOpt != "" )
	{
		bHealthPickupRestore = bool(InOpt);
	}
	InOpt = ParseOption( Options, "MaxBeer");
	if ( int(InOpt) > 0 )
	{
		MaxBeerConsumption = int(InOpt);
	}
	InOpt = ParseOption( Options, "DrinkSpeed");
	if ( float(InOpt) > 0 )
	{
		fDrinkSpeed = float(InOpt);
	}
	InOpt = ParseOption( Options, "SoberSpeed");
	if ( float(InOpt) > 0 )
	{
		fSoberSpeed = float(InOpt);
	}
	InOpt = ParseOption( Options, "WanderSpeed");
	if ( float(InOpt) > 0 )
	{
		smWanderSpeed = float(InOpt);
	}
	InOpt = ParseOption( Options, "WanderAccel");
	if ( float(InOpt) > 0 )
	{
		smAccel = float(InOpt);
	}
}

function PreBeginPlay()
{	
	local class<CTBPlayerController> PC;
	local class<CTBPlayerReplicationInfo> PRI;
	Super.PreBeginPlay();

	// set-up config
	CTBGameReplicationInfo(GameReplicationInfo).BottlesPerCrate = BottlesPerCrate;

	PC = class<CTBPlayerController>(DynamicLoadObject(PlayerControllerClassName, class'Class'));
	if (PC != none) 
	{
		PC.default.DEFbHealthPickupRestore = bHealthPickupRestore;

		PRI = class<CTBPlayerReplicationInfo>(PC.default.PlayerReplicationInfoClass);
		if (PRI != none)
		{
			PRI.default.DEFMaxBeerConsumption = MaxBeerConsumption;
			PRI.default.DEFfDrinkSpeed = fDrinkSpeed;
			PRI.default.DEFfSoberSpeed = fSoberSpeed;
			PRI.default.DEFsmWanderSpeed = smWanderSpeed;
			PRI.default.DEFsmAccel = smAccel;
		}
		else Warn(PC.default.PlayerReplicationInfoClass@"is invalid");
	}
	else Warn(PlayerControllerClassName@"is invalid");

	ReplaceFlags();
}

function PostBeginPlay()
{	
	Super.PostBeginPlay();
	HideOldFlags();
}

function ReplaceFlags()
{
	local xRealCTFBase FB;
	local BeerBase B;
	local vector NewLoc;

	ForEach AllActors(Class'xRealCTFBase', FB)
	{
		if (BeerBase(FB) == none)
		{
			NewLoc = FB.Location;
			if (xBlueFlagBase(FB) != none)
			{
				B = Spawn(class'xBlueBeerBase', FB.Owner, FB.tag, NewLoc, FB.Rotation);
			}
			else {
				B = Spawn(class'xRedBeerBase', FB.Owner, FB.tag, NewLoc, FB.Rotation);
			}
			if ( B != None )
			{
				B.event = FB.event;
				B.tag = FB.tag;				
			}
			FB.FlagType = none; // so the other flag won't spawn
		}
	}
}

function HideOldFlags()
{
	local xRealCTFBase FB;

	ForEach AllActors(Class'xRealCTFBase', FB)
	{
		if (BeerBase(FB) == none)
		{
			FB.bHidden = true;
		}
	}
}

// almost completely the same as the original
// execpt:
//	- all messages are: CTBMessage
//	- team score increase = bottles left
function ScoreFlag(Controller Scorer, CTFFlag theFlag)
{
	local float Dist,oppDist;
	local int i, BottlesLeft;
	local float ppp,numtouch;
	local vector FlagLoc;

	BottlesLeft = BeerCrate(theFlag).BottlesLeft;

	if ( Scorer.PlayerReplicationInfo.Team == theFlag.Team )
	{
		Scorer.AwardAdrenaline(ADR_Return);
		FlagLoc = TheFlag.Position().Location;
		Dist = vsize(FlagLoc - TheFlag.HomeBase.Location);
		
		if (TheFlag.TeamNum==0)
			oppDist = vsize(FlagLoc - Teams[1].HomeBase.Location);
		else
			oppDist = vsize(FlagLoc - Teams[0].HomeBase.Location); 
	
		GameEvent("flag_returned",""$theFlag.Team.TeamIndex,Scorer.PlayerReplicationInfo);
		BroadcastLocalizedMessage( class'CTBMessage', 1, Scorer.PlayerReplicationInfo, None, TheFlag.Team );
		
		if (Dist>1024)
		{
			// figure out who's closer
				
			if (Dist<=oppDist)	// In your team's zone
			{
				Scorer.PlayerReplicationInfo.Score += BottlesLeft*0.3;
				ScoreEvent(Scorer.PlayerReplicationInfo, BottlesLeft*0.3, "flag_ret_friendly");
			}
			else
			{
				Scorer.PlayerReplicationInfo.Score += BottlesLeft*0.5;
				ScoreEvent(Scorer.PlayerReplicationInfo, BottlesLeft*0.5, "flag_ret_enemy");
				
				if (oppDist<=1024)	// Denial
				{
					Scorer.PlayerReplicationInfo.Score += BottlesLeft*0.7;
					ScoreEvent(Scorer.PlayerReplicationInfo, BottlesLeft*0.7, "flag_denial");
				}					
			}					
		} 
		return;
	}
	
	// Figure out Team based scoring.
	if (TheFlag.FirstTouch!=None)	// Original Player to Touch it gets 5
	{
		ScoreEvent(TheFlag.FirstTouch.PlayerReplicationInfo, BottlesLeft*0.5, "flag_cap_1st_touch");
		TheFlag.FirstTouch.PlayerReplicationInfo.Score +=  BottlesLeft*0.5;
	}
		
	// Guy who caps gets 5
	Scorer.PlayerReplicationInfo.Score +=  BottlesLeft*0.5;
	IncrementGoalsScored(Scorer.PlayerReplicationInfo);
		Scorer.AwardAdrenaline(ADR_Goal);
	
	// Each player gets 20/x but it's guarenteed to be at least 1 point but no more than 5 points 
	numtouch=0;	
	for (i=0;i<TheFlag.Assists.length;i++)
	{
		if (TheFlag.Assists[i]!=None)
			numtouch = numtouch + 1.0;
	}
	
	ppp = FClamp(BottlesLeft/numtouch, 1,  BottlesLeft*0.5);
		
	for (i=0; i<TheFlag.Assists.length; i++)
	{
		if (TheFlag.Assists[i]!=None)
		{
			ScoreEvent(TheFlag.Assists[i].PlayerReplicationInfo, ppp, "flag_cap_assist");
			TheFlag.Assists[i].PlayerReplicationInfo.Score += int(ppp);
		}
	}

	// Apply the team score
	Scorer.PlayerReplicationInfo.Team.Score += BottlesLeft;
	ScoreEvent(Scorer.PlayerReplicationInfo, BottlesLeft*0.5, "flag_cap_final");
	TeamScoreEvent(Scorer.PlayerReplicationInfo.Team.TeamIndex, BottlesLeft, "flag_cap");	
	GameEvent("flag_captured", ""$theflag.Team.TeamIndex, Scorer.PlayerReplicationInfo);

	BroadcastLocalizedMessage( class'CTBMessage', 0, Scorer.PlayerReplicationInfo, None, TheFlag.Team );
	AnnounceScore(Scorer.PlayerReplicationInfo.Team.TeamIndex);
	CheckScore(Scorer.PlayerReplicationInfo);

	if ( bOverTime )
	{
		EndGame(Scorer.PlayerReplicationInfo,"timelimit");
	}
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	local int i;
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting("Rules",  "BottlesPerCrate",			default.CTBPropsDisplayText[i++], 0,  20, "Text",	"3;1;999");
	PlayInfo.AddSetting("Rules",  "bHealthPickupRestore", default.CTBPropsDisplayText[i++], 0,  20, "Check");
	PlayInfo.AddSetting("Rules",  "MaxBeerConsumption",		default.CTBPropsDisplayText[i++], 0,  20, "Text",	"3;1;999");
	PlayInfo.AddSetting("Rules",  "fDrinkSpeed",					default.CTBPropsDisplayText[i++], 0,  20, "Text",	"5;0;99999");
	PlayInfo.AddSetting("Rules",  "fSoberSpeed",					default.CTBPropsDisplayText[i++], 0,  20, "Text",	"5;0;99999");
	PlayInfo.AddSetting("Rules",  "smWanderSpeed",				default.CTBPropsDisplayText[i++], 0,  20, "Text",	"5;0;99999");
	PlayInfo.AddSetting("Rules",  "smAccel",							default.CTBPropsDisplayText[i++], 0,  20, "Text",	"5;0;99999");
}

function GetServerDetails( out ServerResponseLine ServerState )
{
	local int i;
	Super.GetServerDetails( ServerState );

	i = ServerState.ServerInfo.Length;

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "BottlesPerCrate";
	ServerState.ServerInfo[i++].Value = string(BottlesPerCrate);

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "MaxBeerConsumption";
	ServerState.ServerInfo[i++].Value = string(MaxBeerConsumption);

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "HealthPickupRestores";
	ServerState.ServerInfo[i++].Value = string(bHealthPickupRestore);
}

defaultproperties
{
	GameName="Capture the Beer"
	Acronym="CTB"
	GameReplicationInfoClass=class'CaptureTheBeer.CTBGameReplicationInfo'
	PlayerControllerClassName="CaptureTheBeer.CTBPlayerController"
	HUDType="CaptureTheBeer.CTBHUD"

	GoalScore=72
	// GRI
	BottlesPerCrate=24
	// PC
	bHealthPickupRestore=true
	// PRI
	MaxBeerConsumption=24
	fDrinkSpeed=20
	fSoberSpeed=60
	smWanderSpeed=500
	smAccel=2.5

	CTBPropsDisplayText(0)="Bottles Per Crate"
	CTBPropsDisplayText(1)="Health Restores Consumption"
	CTBPropsDisplayText(2)="Max. Beer Consumption"
	CTBPropsDisplayText(3)="Drinking Speed"
	CTBPropsDisplayText(4)="Sobering Speed"
	CTBPropsDisplayText(5)="Mouse Wander Speed"
	CTBPropsDisplayText(6)="Mouse Wander Acceleration"
}