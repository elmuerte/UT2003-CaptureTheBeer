////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// The new base for the beer crates
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: BeerBase.uc,v 1.2 2003/10/20 13:39:24 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class BeerBase extends xRealCTFBase abstract;

defaultproperties
{
	bNoDelete=false
	bStatic=false

	DrawType=DT_StaticMesh
	//DrawScale=0.15	
	//StaticMesh=StaticMesh'Editor.TexPropCube'
	DrawScale=0.8
	StaticMesh=StaticMesh'CTBmesh.BeerCrateMesh'
}