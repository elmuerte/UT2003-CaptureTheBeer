////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// The ingame beer crate you can carry around
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: BeerCrate.uc,v 1.3 2003/10/20 09:19:32 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class BeerCrate extends CTFflag abstract;

/** number of bottles left in this crate */
var int BottlesLeft;

replication
{
	reliable if ( Role == ROLE_Authority )
		BottlesLeft;
}

function bool ValidHolder(Actor Other)
{
	local CTBPlayerReplicationInfo ctbi;

	if (!super.ValidHolder(Other)) return false;
	ctbi = CTBPlayerReplicationInfo(Pawn(Other).Controller.PlayerReplicationInfo);
	if (ctbi != none)
	{
		if (ctbi.BeerConsumption >= ctbi.MaxBeerConsumption)
		{
			if (PlayerController(Pawn(Other).Controller) != none)
				PlayerController(Pawn(Other).Controller).ReceiveLocalizedMessage( MessageClass, 9 );
			return false;
		}
	}
	return true;
}


auto state Home
{
begin:
	BottlesLeft = CTBGameReplicationInfo(GRI).BottlesPerCrate;
}

function OutOfBeer()
{
	BroadcastLocalizedMessage( MessageClass, 7, Holder.PlayerReplicationInfo, None, Team );
	// TODO: out of beer message
	UnrealMPGameInfo(Level.Game).GameEvent("flag_dropped",""$Team.TeamIndex, Holder.PlayerReplicationInfo);
	ClearHolder();
	CalcSetHome();
  GotoState('Home');
}

function TooMuchToDrink()
{
	BroadcastLocalizedMessage( MessageClass, 8, Holder.PlayerReplicationInfo, None, Team );
	UnrealMPGameInfo(Level.Game).GameEvent("flag_dropped",""$Team.TeamIndex, Holder.PlayerReplicationInfo);
	Drop(Holder.velocity * 0.5);
}

defaultproperties
{
	MessageClass=class'CaptureTheBeer.CTBMessage'
	PrePivot=(X=-10,Y=5,Z=-0.5)
	DrawScale=0.1
	DrawType=DT_StaticMesh
	StaticMesh=StaticMesh'Editor.TexPropCube'
	
	bDynamicLight=true
	LightHue=40
	LightBrightness=200
	bUnlit=true
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightRadius=6
}