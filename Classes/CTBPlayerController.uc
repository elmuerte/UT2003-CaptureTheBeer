////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Modified controller for drunk behavior
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBPlayerController.uc,v 1.3 2003/10/22 11:14:26 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBPlayerController extends xPlayer;

var bool bHealthPickupRestore, DEFbHealthPickupRestore;

replication
{
	reliable if ( Role == ROLE_Authority )		
		bHealthPickupRestore;
}

event BeginPlay()
{
	Super.BeginPlay();
	bHealthPickupRestore = default.DEFbHealthPickupRestore;
}

function HandlePickup(Pickup pick)
{
	Super.HandlePickup(pick);
	if (TournamentHealth(pick) != none && bHealthPickupRestore)
	{
		if (CTBPlayerReplicationInfo(PlayerReplicationInfo).BeerConsumption > 0)
			CTBPlayerReplicationInfo(PlayerReplicationInfo).BeerConsumption -= 
				CTBPlayerReplicationInfo(PlayerReplicationInfo).MaxBeerConsumption*(float(TournamentHealth(pick).HealingAmount)/100.0);
	}
}

defaultproperties
{
	PlayerReplicationInfoClass=Class'CaptureTheBeer.CTBPlayerReplicationInfo'
	InputClass=class'CaptureTheBeer.CTBInput'
}