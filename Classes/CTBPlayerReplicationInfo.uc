////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Replication info for the player
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBPlayerReplicationInfo.uc,v 1.5 2003/10/22 11:14:26 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBPlayerReplicationInfo extends xPlayerReplicationInfo;

#exec AUDIO IMPORT FILE="Sounds\Consume.wav" NAME="ConsumeSound"

/** number of beer bottles consumed */
var float BeerConsumption;
/** maximum a person can drink */
var() float MaxBeerConsumption;
var float DEFMaxBeerConsumption;

var sound ConsumeBeer;

var() float fDrinkSpeed, fSoberSpeed;
var float DEFfDrinkSpeed, DEFfSoberSpeed; // defauls
var float curDrunkSpeed, curSoberSpeed;

// beer effect settings
/** the amplitude */
var() float smWanderSpeed, DEFsmWanderSpeed;
/** the acceleration */
var() float smAccel, DEFsmAccel;
/** direction */
var float smWanderDirX, smWanderDirY;

replication
{
	reliable if ( Role == ROLE_Authority )
		BeerConsumption;

	reliable if ( Role == ROLE_Authority )
		MaxBeerConsumption, fDrinkSpeed, fSoberSpeed, smWanderSpeed, smAccel;
}

event BeginPlay()
{
	Super.BeginPlay();
	MaxBeerConsumption = default.DEFMaxBeerConsumption;
	fDrinkSpeed = default.DEFfDrinkSpeed;
	fSoberSpeed = default.DEFfSoberSpeed;
	smWanderSpeed = default.DEFsmWanderSpeed;
	smAccel = default.DEFsmAccel;
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
			GameObject(HasFlag).Holder.PlaySound(ConsumeBeer, SLOT_Interface);
			if (BeerCrate(HasFlag) != none)
			{
				BeerCrate(HasFlag).BottlesLeft--;
				if (BeerCrate(HasFlag).BottlesLeft <= 0) BeerCrate(HasFlag).OutOfBeer();
				else if (BeerConsumption >= MaxBeerConsumption) BeerCrate(HasFlag).TooMuchToDrink();
			}
		}
	}
	else curDrunkSpeed = 0; // always consume the first bottle

	if (BeerConsumption < 0) BeerConsumption = 0;
}

defaultproperties
{	
	smWanderDirX=1
	smWanderDirY=1
	ConsumeBeer=sound'CaptureTheBeer.ConsumeSound'
}