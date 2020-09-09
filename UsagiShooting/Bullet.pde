/* 弾クラス(基底) */
abstract class Bullet{
  protected PVector location;  //位置ベクトル
  protected PVector velocity;  //速度ベクトル
  protected PVector gravity;   //重力ベクトル
  protected float range;    //弾の当たり判定範囲
  
  //** コンストラクタ
  Bullet(PVector location,PVector velocity,PVector gravity){
    this.location = location;
    this.velocity = velocity;
    if(gravity != null){
      this.gravity = gravity;
    }else{
      this.gravity = new PVector(0.0,0.0);  //重力不使用
    }
    this.range = 0.0;
  }
  
  //** 弾を描画
  abstract void draw();
  
  //** 弾の位置を更新
  void updateLocation(){
    location.add(velocity); //<>//
    location.add(gravity);
  }
  
  //**自機への当たり判定
  boolean isHitToPlayer(Player player){
    float Lx = location.x - range;  //敵機左端
    float Rx = location.x + range;  //敵機右端
    float Uy = location.y - range;  //敵機上端
    float Dy = location.y + range;  //敵機下端
    
    float playerX = player.getLocation().x;
    float playerY = player.getLocation().y;
    float PLx = playerX - Const.RANGE_HIT_PLAYER;  //自機左端
    float PRx = playerX + Const.RANGE_HIT_PLAYER;  //自機右端
    float PUy = playerY - Const.RANGE_HIT_PLAYER;  //自機上端
    float PDy = playerY + Const.RANGE_HIT_PLAYER;  //自機下端
    
    if(Lx < PRx && Rx > PLx){
      if(Uy < PDy && Dy > PUy){
        return true;
      }
    }
    
    return false;
    
  }
  
  //**弾が画面外にはみ出しているか判定
  boolean isOutOfScreen(){
    if(location.x < 0 || location.x > width){
      return true;
    }
    if(location.y < 0 || location.y > height){
      return true;
    }
    return false;
  }
  
}

/*------------------------------------------------------------*/
/* 小弾クラス */
class SmallBullet extends Bullet{
  
  //** コンストラクタ
  SmallBullet(PVector location,PVector velocity,PVector gravity){
    super(location,velocity,gravity);
    this.range = 2.5;
  }
  
  //** 弾を描画
  void draw(){
    fill(65,105,225);
    noStroke();
    ellipse(location.x,location.y,10,10);
  }
  
}