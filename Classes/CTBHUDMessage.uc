////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Hud message that the player has the crate
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBHUDMessage.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBHUDMessage extends CTFHUDMessage;

static function string RepText(string in, string replace, coerce string with)
{
	local int i;
	i = InStr(in, replace);
	while (i > -1)
	{
		in = Left(in, i)$with$Mid(in, i+Len(replace));
		i = InStr(in, replace);
	}
	return in;
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (Switch == 0)
		return RepText(Default.YouHaveFlagString, "%num%", BeerCrate(OptionalObject).BottlesLeft);
	else
		return Default.EnemyHasFlagString;
}

defaultproperties
{
	YouHaveFlagString="You have the crate, %num% bottles left!"
	EnemyHasFlagString="The enemy has your beer crate, recover it!"
}