////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// red beer crate
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xRedBeerCrate.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xRedBeerCrate extends BeerCrate;

defaultproperties
{
	Mesh=Mesh'XGame_rc.FlagMesh'
	Skins(0)=XGameShaders.RedFlagShader_F
	DrawScale=0.9
	LightHue=0
	TeamNum=0
}
