////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Beer action messages
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBMessage.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBMessage extends CTFMessage;

var localized string NoBeerRed, NoBeerBlue;
var localized string TooMuchToDrink;

static simulated function ClientReceive( 
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
	if ( TeamInfo(OptionalObject) == None ) return;
	switch (Switch)
	{
		case 7: // out of beer
		case 8: // too much beer, dropped it
						Super.ClientReceive(P, 2, RelatedPRI_1, RelatedPRI_2, OptionalObject);
						break;
		case 9: // too much beer
	}
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if ( TeamInfo(OptionalObject) == None )
		return "";
	switch (Switch)
	{		
		case 0: // Captured the flag.		
		case 1: // Returned the flag.		
		case 2: // Dropped the flag.
		case 3: // Was returned.
		case 4: // Has the flag.
		case 5: // Auto send home.
		case 6: // Pickup
			return super.GetString(Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

		case 7: // out of beer
			if (RelatedPRI_1 == None)
				return "";
			if ( TeamInfo(OptionalObject).TeamIndex == 0 ) 
				return RelatedPRI_1.playername@Default.NoBeerRed;
			else
				return RelatedPRI_1.playername@Default.NoBeerBlue;
			break;
		case 8: // dropped flag because to much beer
				return super.GetString(2, RelatedPRI_1, RelatedPRI_2, OptionalObject);
		case 9: // to much beer
				return Default.TooMuchToDrink;
	}
	return "";
}

defaultproperties
{
	ReturnBlue="returned the blue beer crate!" 
	ReturnRed="returned the red beer crate!"
	ReturnedBlue="The blue beer crate was returned!"
	ReturnedRed="The red beer crate was returned!"
	CaptureBlue="captured the blue beer crate!"
	CaptureRed="captured the red beer crate!"
	DroppedBlue="dropped the blue beer crate!"
	DroppedRed="dropped the red beer crate!"
	HasRed="took the red beer crate!"
	HasBlue="took the blue beer crate!"

	NoBeerRed="ran out of beer, red beer create returned"
	NoBeerBlue="ran out of beer, blue beer create returned"
	TooMuchToDrink="You've had to much to drink"
}