////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// Blue beer base
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xBlueBeerBase.uc,v 1.2 2003/10/20 13:39:24 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xBlueBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=XGameTextures.utx

defaultproperties
{
	DefenseScriptTags=DefendBlueFlag
	DefenderTeamIndex=1    
	ObjectiveName="Blue Beer Crate Base"
	FlagType=class'CaptureTheBeer.xBlueBeerCrate'   
	Skins(0)=XGameShaders.BlueFlagShader_F
}