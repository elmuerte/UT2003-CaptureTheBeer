////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// The ingame beer crate you can carry around
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: BeerCrate.uc,v 1.7 2003/10/21 22:08:55 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class BeerCrate extends CTFflag abstract;

/** number of bottles left in this crate */
var int BottlesLeft;

replication
{
	reliable if ( Role == ROLE_Authority )
		BottlesLeft;
}

// DONT
simulated function UpdateForTeam();

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
	ClearHolder();
	CalcSetHome();
  GotoState('Home');
}

function TooMuchToDrink()
{
	BroadcastLocalizedMessage( MessageClass, 8, Holder.PlayerReplicationInfo, None, Team );
	Drop(Holder.velocity * 0.5);
}

defaultproperties
{
	MessageClass=class'CaptureTheBeer.CTBMessage'
	PrePivot=(X=6,Y=2,Z=-0.5)
	DrawType=DT_StaticMesh
	//DrawScale=0.15
	//StaticMesh=StaticMesh'Editor.TexPropCube'
	DrawScale=0.6
	StaticMesh=StaticMesh'CTBmesh.BeerCrateMesh'
	
	bDynamicLight=true
	LightHue=40
	LightBrightness=128
	bUnlit=true
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightRadius=6
}