////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Blue beer base
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xBlueBeerBase.uc,v 1.3 2003/10/20 21:15:53 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xBlueBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=CTBtex.utx

defaultproperties
{
	DefenseScriptTags=DefendBlueFlag
	DefenderTeamIndex=1    
	ObjectiveName="Blue Beer Crate Base"
	FlagType=class'CaptureTheBeer.xBlueBeerCrate'   
	Skins(0)=CTBtex.Crate.BlueSide
	Skins(1)=CTBtex.Crate.BlueSide
	Skins(2)=CTBtex.Crate.BlueTop
	Skins(3)=CTBtex.Crate.BlueBottom
}