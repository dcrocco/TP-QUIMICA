package  {
	
	import flash.display.MovieClip;
	
	
	public class Pelotita extends MovieClip {
		
		//Declaración de variables
		public var posicionInicialX;
		public var posicionInicialY;
		public var directionY;
		public var directionX;
		private var recipienteX;
		private var recipienteY;
		private var recipienteWidth;
		private var recipienteHeight;

		/** Constructor de la clase pelotita
		@param recipienteWidth Ancho del recipiente
		@param recipienteHeight Alto del recipiente
		@param recipienteX Posición del recipiente en el eje X
		@param recipienteY Posición del recipiente en el eje Y
		*/
		public function Pelotita(recipienteWidth:Number, recipienteHeight:Number, recipienteX:Number, recipienteY:Number) {

			//Inicialización de variables
			this.recipienteX = recipienteX;
			this.recipienteY = recipienteY;
			this.recipienteHeight = recipienteHeight;
			this.recipienteWidth = recipienteWidth;
			
			//Cálculo de posición inicial
			this.posicionInicialX = Math.round((Math.random() * (recipienteWidth - this.width/2))) + recipienteX 
			this.posicionInicialY = Math.round((Math.random() * (recipienteHeight - this.height/2))) + recipienteY
			
			if (this.posicionInicialX <= recipienteX + this.width/2){
				this.posicionInicialX = recipienteX + this.width/2
			}
			
			if (this.posicionInicialY <= recipienteY + this.height/2){
				this.posicionInicialY = recipienteY + this.height/2
			}
			
			//Cálculo de dirección inicial
			this.setDirections();

		}
		
		
		/* Mueve las pelotitas un pixel en Y y en X.
		**/
		public function mover():void{
			
			this.analisePosition();
			if (this.directionX == 'right'){
				
				this.x += 1;
			}else{
				
				this.x -= 1;
			}
			
			if (this.directionY == 'bottom'){
				
				this.y += 1;
			}else{
				this.y -=1;
			}
		}
		
		/* Seteo de direcciones aleatorias luego de la inicialización.
		**/
		private function setDirections():void{
						
			var randomX = Math.random();
			var randomY = Math.random();
			
			if (randomX < 0.5){
				
				this.directionX = 'left';
				
			}else{
			
				this.directionX = 'right';
			}
			
			if (randomY < 0.5){
				
				this.directionY = 'top'
				
			}else{
				
				this.directionY = 'bottom'
				
			}
		}
			
		/* Cambia la dirección de las pelotitas en base a la posición actual,
		para poder manejar los rebotes dentro del recipiente
		**/
		private function analisePosition():void{
			
			if (this.y <= this.recipienteY + this.height/2){
				
				this.directionY = 'bottom';
				
			}else if (this.y >= this.recipienteY + this.recipienteHeight - this.height/2){
		
				this.directionY = 'top';
			}
			
			if (this.x <= this.recipienteX + this.width/2){
				this.directionX = 'right';
				
			}else if (this.x >= this.recipienteX + this.recipienteWidth - this.width/2){
				
				this.directionX = 'left';
			}
		}
		
		/* Cambia la dirección de las pelotitas a la dirección del string.
		 @param direction dirección la cual se va a cambiar
		 **/
		public function changeDirection(direction:String){
			
			if (direction == 'top') this.directionY = 'top';
			if (direction == 'bottom') this.directionY = 'bottom';
			if (direction == 'right') this.directionX = 'right';
			if (direction == 'left') this.directionX = 'left';
		}
	}
	
}
