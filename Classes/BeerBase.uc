////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// The new base for the beer crates
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: BeerBase.uc,v 1.3 2003/10/21 10:59:56 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class BeerBase extends xRealCTFBase abstract;

// DONT
simulated function UpdateForTeam();

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