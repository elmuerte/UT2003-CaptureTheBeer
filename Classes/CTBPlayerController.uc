////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Modified controller for drunk behavior
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBPlayerController.uc,v 1.2 2003/10/16 15:52:18 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBPlayerController extends xPlayer;

var bool bHealthPickupRestore;

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

	bHealthPickupRestore=true
}