////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// blue beer crate
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xBlueBeerCrate.uc,v 1.1 2003/10/16 15:14:45 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xBlueBeerCrate extends BeerCrate;

defaultproperties
{
	Mesh=Mesh'XGame_rc.FlagMesh'
	Skins(0)=XGameShaders.BlueFlagShader_F
	DrawScale=0.9
	LightHue=130
	TeamNum=1
}
