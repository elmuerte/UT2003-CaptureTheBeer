////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Game Replication Info
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBGameReplicationInfo.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBGameReplicationInfo extends GameReplicationInfo;

var config int BottlesPerCrate;

defaultproperties
{
	BottlesPerCrate=25
}