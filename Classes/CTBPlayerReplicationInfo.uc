////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Replication info for the player
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBPlayerReplicationInfo.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBPlayerReplicationInfo extends xPlayerReplicationInfo;

/** number of beer bottles consumed */
var float BeerConsumption;
/** maximum a person can drink */
var(CTB) config float MaxBeerConsumption;

var sound ConsumeBeer;

var(CTB) config float fDrinkSpeed, fSoberSpeed;
var float curDrunkSpeed, curSoberSpeed;

// beer effect settings
/** the amplitude */
var(CTB) config float smWanderSpeed;
/** the acceleration */
var(CTB) config float smAccel;
/** direction */
var float smWanderDirX, smWanderDirY;

replication
{
	reliable if ( Role == ROLE_Authority )
		BeerConsumption;
}

event tick(float deltatime)
{
	if ((BeerConsumption > 0) && (HasFlag == none))
	{
		curSoberSpeed -= deltatime;
		if (curSoberSpeed <= 0)
		{
			curSoberSpeed = fSoberSpeed;
			BeerConsumption -= 1;
		}
	}
	else curSoberSpeed = fSoberSpeed;

	if (HasFlag != none)
	{
		curDrunkSpeed -= deltatime;
		if (curDrunkSpeed <= 0)
		{
			curDrunkSpeed = fDrinkSpeed;
			BeerConsumption += 1;
			if (ConsumeBeer != none) PlayOwnedSound(ConsumeBeer, SLOT_Interact);
			if (BeerCrate(HasFlag) != none)
			{
				BeerCrate(HasFlag).BottlesLeft--;
				if (BeerCrate(HasFlag).BottlesLeft <= 0) BeerCrate(HasFlag).OutOfBeer();
				else if (BeerConsumption >= MaxBeerConsumption) BeerCrate(HasFlag).TooMuchToDrink();
			}
		}
	}
	else curDrunkSpeed = 0; // always consume the first bottle
}

defaultproperties
{
	MaxBeerConsumption=24
	fDrinkSpeed=15
	fSoberSpeed=30

	smWanderSpeed=500
	smAccel=2.5
	smWanderDirX=1
	smWanderDirY=1

	//ConsumeBeer=sound'CaptureTheBeer.Consume'
}