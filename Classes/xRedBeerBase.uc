class xRedBeerBase extends BeerBase placeable;

#exec OBJ LOAD FILE=XGameTextures.utx

simulated function PostBeginPlay()
{
	/*
    local xCTFBase xbase;

    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {    
        xbase = Spawn(class'XGame.xCTFBase',self,,Location-BaseOffset,rot(0,0,0));
    }
	*/
}

defaultproperties
{
	DefenseScriptTags=DefendRedFlag
	DefenderTeamIndex=0
	ObjectiveName="Red Beer Crate Base"
	FlagType=class'CaptureTheBeer.xRedBeerCrate'   
	Skins(0)=XGameShaders.RedFlagShader_F

}