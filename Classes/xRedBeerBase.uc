////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Red beer base
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xRedBeerBase.uc,v 1.3 2003/10/20 21:15:53 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xRedBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=CTBtex.utx

defaultproperties
{
	DefenseScriptTags=DefendRedFlag
	DefenderTeamIndex=0
	ObjectiveName="Red Beer Crate Base"
	FlagType=class'CaptureTheBeer.xRedBeerCrate'   
	Skins(0)=CTBtex.Crate.RedSide
	Skins(1)=CTBtex.Crate.RedSide
	Skins(2)=CTBtex.Crate.RedTop
	Skins(3)=CTBtex.Crate.RedBottom
}