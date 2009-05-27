package math {
	public class SimpleMath {
		public function add( n1:Number, n2:Number ):Number {
			return (n1+n2);
		}

		public function subtract( n1:Number, n2:Number ):Number {
			return (n1-n2);
		}

		public function multiply( n1:Number, n2:Number ):Number {
			return (n1*n2);
		}

		public function divide( n1:Number, n2:Number ):Number {
			if ( n2 == 0 ) {
				throw new TypeError("Cannot divide by 0");
			}
			return (n1/n2);
		}
	}
}