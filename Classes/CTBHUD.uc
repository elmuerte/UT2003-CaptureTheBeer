////////////////////////////////////////////////////////////////////////////////
// Capture The Beer
// The new HUD, adds beer consumption counter
//
// Copyright 2003, Michiel "El Muerte" Hendriks
// $Id: CTBHUD.uc,v 1.2 2003/10/16 21:58:30 elmuerte Exp $
////////////////////////////////////////////////////////////////////////////////

class CTBHUD extends HudBCaptureTheFlag;

#exec TEXTURE IMPORT NAME=BeerIcon FILE=TEXTURES\beericon.dds ALPHA=1 LODSET=LODSET_Interface

var float CurrentBeer, LastBeer, MaxBeer;

var() SpriteWidget	Beer[5];
var() NumericWidget BeerCount;
var() SpriteWidget	BeerIcon;

simulated function DrawHudPassA (Canvas C)
{
	super.DrawHudPassA(c);

	DrawSpriteWidget (C, Beer[2] );
  DrawSpriteWidget (C, Beer[1] );
}

simulated function DrawHudPassC (Canvas C)
{
	super.DrawHudPassC(c);
	DrawSpriteWidget (C, Beer[0]);
  DrawSpriteWidget (C, Beer[3]);
  DrawSpriteWidget (C, Beer[4]);
  DrawNumericWidget(C, BeerCount, DigitsBig);
  DrawSpriteWidget (C, BeerIcon);
}

simulated function UpdateHud()
{
	super.UpdateHud();
	Beer[2].Scale = CurrentBeer/MaxBeer;
}

simulated function CalculateHealth()
{
	Super.CalculateHealth();

	LastBeer = CurrentBeer;
	if ( PawnOwner.Controller == None )
	{
		CurrentBeer = CTBPlayerReplicationInfo(PlayerOwner.PlayerReplicationInfo).BeerConsumption;
		MaxBeer = CTBPlayerReplicationInfo(PlayerOwner.PlayerReplicationInfo).MaxBeerConsumption;
	}
	else {
		CurrentBeer = CTBPlayerReplicationInfo(PawnOwner.Controller.PlayerReplicationInfo).BeerConsumption;
		MaxBeer = CTBPlayerReplicationInfo(PawnOwner.Controller.PlayerReplicationInfo).MaxBeerConsumption;
	}
	BeerCount.Value = round(CurrentBeer);
}

function Timer()
{
	Super(HudBTeamDeathMatch).Timer();

	if ( (PawnOwnerPRI == None) || (PlayerOwner.IsSpectating() && (PlayerOwner.bBehindView || (PlayerOwner.ViewTarget == PlayerOwner))) )
		return;

	if ( PawnOwnerPRI.HasFlag != None )
		PlayerOwner.ReceiveLocalizedMessage( class'CTBHUDMessage', 0,,, PawnOwnerPRI.HasFlag );

	if ( (PlayerOwner.GameReplicationInfo != None)
		&& (PlayerOwner.GameReplicationInfo.FlagState[PlayerOwner.PlayerReplicationInfo.Team.TeamIndex] == EFlagState.FLAG_HeldEnemy) )
		PlayerOwner.ReceiveLocalizedMessage( class'CTBHUDMessage', 1 );
}

defaultproperties
{
	// Beer
	Beer[0]=(WidgetTexture=Material'InterfaceContent.Hud.SkinA',TextureCoords=(X1=611,Y1=900,X2=979,Y2=1023),TextureScale=0.23,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=95,OffsetY=10,ScaleMode=SM_Right,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=255,G=255,B=255,A=255),Tints[1]=(R=255,G=255,B=255,A=255))
	Beer[1]=(WidgetTexture=Material'InterfaceContent.Hud.SkinA',TextureCoords=(X1=611,Y1=777,X2=979,Y2=899),TextureScale=0.23,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=95,OffsetY=10,ScaleMode=SM_Left,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=100,G=0,B=0,A=100),Tints[1]=(R=37,G=66,B=102,A=150))
	Beer[2]=(WidgetTexture=Material'InterfaceContent.Hud.SkinA',TextureCoords=(X1=611,Y1=654,X2=979,Y2=776),TextureScale=0.23,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=95,OffsetY=10,ScaleMode=SM_Right,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=100,G=0,B=0,A=200),Tints[1]=(R=48,G=75,B=120,A=200))
	Beer[3]=(WidgetTexture=Material'InterfaceContent.Hud.SkinA',TextureCoords=(X1=0,Y1=880,X2=142,Y2=1023),TextureScale=0.23,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=0,OffsetY=0,ScaleMode=SM_Right,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=255,G=255,B=255,A=255),Tints[1]=(R=255,G=255,B=255,A=255))
	Beer[4]=(WidgetTexture=Material'InterfaceContent.Hud.SkinA',TextureCoords=(X1=810,Y1=200,X2=1023,Y2=413),TextureScale=0.2,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=35,OffsetY=-28,ScaleMode=SM_Right,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=255,G=255,B=0,A=0),Tints[1]=(R=255,G=255,B=0,A=0))

	BeerIcon=(WidgetTexture=Material'CaptureTheBeer.BeerIcon',TextureCoords=(X1=0,Y1=0,X2=128,Y2=128),TextureScale=0.23,DrawPivot=DP_UpperLeft,PosX=0,PosY=0,OffsetX=0,OffsetY=0,ScaleMode=SM_None,Scale=1.0,RenderStyle=STY_Alpha,Tints[0]=(R=255,G=255,B=255,A=255),Tints[1]=(R=255,G=255,B=255,A=255))

	BeerCount=(TextureScale=0.18,MinDigitCount=2,DrawPivot=DP_UpperRight,PosX=0,PosY=0,OffsetX=560,OffsetY=40,RenderStyle=STY_Alpha,Tints[0]=(R=255,G=255,B=255,A=255),Tints[1]=(R=255,G=255,B=255,A=255))

}