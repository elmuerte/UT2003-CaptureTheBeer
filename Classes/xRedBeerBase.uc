////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Red beer base
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xRedBeerBase.uc,v 1.2 2003/10/20 13:39:24 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xRedBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=XGameTextures.utx

defaultproperties
{
	DefenseScriptTags=DefendRedFlag
	DefenderTeamIndex=0
	ObjectiveName="Red Beer Crate Base"
	FlagType=class'CaptureTheBeer.xRedBeerCrate'   
	Skins(0)=XGameShaders.RedFlagShader_F

}