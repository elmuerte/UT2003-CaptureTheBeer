////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// red beer crate
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: xRedBeerCrate.uc,v 1.3 2003/10/20 21:15:53 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class xRedBeerCrate extends BeerCrate;

#exec OBJ LOAD FILE=CTBtex.utx

defaultproperties
{
	Skins(0)=CTBtex.Crate.RedSide
	Skins(1)=CTBtex.Crate.RedSide
	Skins(2)=CTBtex.Crate.RedTop
	Skins(3)=CTBtex.Crate.RedBottom
	LightHue=0
	TeamNum=0
}
