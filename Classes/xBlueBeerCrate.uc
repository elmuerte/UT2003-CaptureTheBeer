////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// blue beer crate
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xBlueBeerCrate.uc,v 1.3 2003/10/20 21:15:53 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xBlueBeerCrate extends BeerCrate;

#exec OBJ LOAD FILE=CTBtex.utx

defaultproperties
{	
	Skins(0)=CTBtex.Crate.BlueSide
	Skins(1)=CTBtex.Crate.BlueSide
	Skins(2)=CTBtex.Crate.BlueTop
	Skins(3)=CTBtex.Crate.BlueBottom
	LightHue=130
	TeamNum=1
}
