////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Game class
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBgame.uc,v 1.2 2003/10/20 09:19:32 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBgame extends xCTFgame;

function PreBeginPlay()
{	
	Super.PreBeginPlay();
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
			NewLoc.Y = NewLoc.Y-10;
			if (xBlueFlagBase(FB) != none)
			{
				B = Spawn(class'CaptureTheBeer.xBlueBeerBase', FB.Owner, FB.tag, NewLoc, FB.Rotation);
			}
			else {
				B = Spawn(class'CaptureTheBeer.xRedBeerBase', FB.Owner, FB.tag, NewLoc, FB.Rotation);
			}
			if ( B != None )
			{
				B.event = FB.event;
				B.tag = FB.tag;
				FB.FlagType = none;
			}
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

defaultproperties
{
	GameName="Capture the Beer"
	Acronym="CTB"
	GameReplicationInfoClass=class'CaptureTheBeer.CTBGameReplicationInfo'
	PlayerControllerClassName="CaptureTheBeer.CTBPlayerController"
	HUDType="CaptureTheBeer.CTBHUD"

	GoalScore=72
}