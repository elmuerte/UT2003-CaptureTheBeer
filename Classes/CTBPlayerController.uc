////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Modified controller for drunk behavior
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBPlayerController.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBPlayerController extends xPlayer;

defaultproperties
{
	PlayerReplicationInfoClass=Class'CaptureTheBeer.CTBPlayerReplicationInfo'
	InputClass=class'CaptureTheBeer.CTBInput'
}