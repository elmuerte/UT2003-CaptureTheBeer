class xBlueBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=XGameTextures.utx

simulated function PostBeginPlay()
{
	/*
    local xCTFBase xbase;

    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {    
        xbase = Spawn(class'XGame.xCTFBase',self,,Location-BaseOffset,rot(0,0,0));
        xbase.Skins[0] = Texture'XGameTextures.FlagBaseTexB';
    }
	*/
}

defaultproperties
{
	DefenseScriptTags=DefendBlueFlag
	DefenderTeamIndex=1    
	ObjectiveName="Blue Beer Crate Base"
	FlagType=class'CaptureTheBeer.xBlueBeerCrate'   
	Skins(0)=XGameShaders.BlueFlagShader_F
}