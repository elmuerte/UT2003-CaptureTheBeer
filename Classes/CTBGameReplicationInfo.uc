////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Game Replication Info
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBGameReplicationInfo.uc,v 1.2 2003/10/16 21:58:30 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBGameReplicationInfo extends GameReplicationInfo;

var config int BottlesPerCrate;

defaultproperties
{
	BottlesPerCrate=24
}