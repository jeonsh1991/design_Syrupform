<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
<script type="text/javascript">
const fishImages = [
	  "https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230831.png",
	  "https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230843.png",
	  "https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230849.png",
	  "https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230855.png",
	  "https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230904.png"
	];

	new Vue({
	  el: "#app",
	  data() {
	    return {
	      rotationX: 0.0,
	      rotationY: 0.0,
	      fishes: [this.generateFish(), this.generateFish()]
	    }
	  },
	  computed: {
	    rotation() {
	      return {
	        transform: `perspective(1000px) rotateY(${this.rotationX}deg) rotateX(${this.rotationY}deg)`
	      }
	    }
	  },
	  mounted() {
	    setInterval(() => {
	      this.fishes.forEach(fish => this.moveFish(fish));
	    }, 41);
	  },
	  methods: {
	    onMouseMoved(e) {
	      console.log(e);
	      const maxRotation = 20.0;
	      const x = (e.pageX / document.body.clientWidth) * 2 - 1;
	      const y = (e.pageY / document.body.clientHeight) * 2 - 1;
	      this.rotationX = maxRotation * x;
	      this.rotationY = -maxRotation * y;
	    },
	    generateFish() {
	      return {
	        image: fishImages[Math.floor(Math.random() * fishImages.length)],
	        x: Math.floor(50 + Math.random() * 200),
	        y: -50 + Math.floor(Math.random() * 100),
	        z: -100 + Math.floor(Math.random() * 200),
	        ax: Math.floor(Math.random() * 2) == 0 ? -1 : 1
	      }
	    },
	    fishStyle(fish) {
	      const flip = fish.ax < 0 ? '1' : '-1';
	      return {
	        left: `${fish.x}px`,
	        transform: `scaleX(${flip}) translateY(${fish.y}px) translateZ(${fish.z}px)`
	      };
	    },
	    moveFish(fish) {
	      if (fish.ax < 0) {
	        if (fish.x <= 30) {
	          fish.ax = -fish.ax;
	        }
	      } else {
	        if (fish.x >= 300) {
	          fish.ax = -fish.ax;
	        }
	      }
	      fish.x += fish.ax;
	    }
	  }
	});
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
html, body {
  height: 100%;
}

#app {
  position: relative;
  width: 100%;
  height: 100%;
}

.container {
  position: relative;
  margin-left: auto;
  margin-right: auto;
  transform-origin: 50%;
  transform-style: preserve-3d;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 400px;
  height: 100%;
}

.bg {
  position: absolute;
  width: 400px;
  transform: translateZ(-200px);
}

.water {
  position: absolute;
  opacity: 0.3;
}

.front {
  width: 400px;
  transform: translateZ(200px);
}

.side {
  width: 400px;  
}

.left {
  left: -200px;
  transform: rotateY(90deg);
}

.right {
  left: 200px;
  transform: rotateY(90deg);
}

.top {
  width: 400px;
  transform: translateY(-130px) rotateX(90deg) scaleY(1.5);
}

.ground {
  width: 400px;
  transform: translateY(130px) rotateX(90deg) scaleY(1.5);
}

.fish {
  position: absolute;
  transform: scaleX(1) translateY(0px) translateZ(0px);
  display: block;
  width: 100px;
}

.fish img {
}

@keyframes vertical {
    0% { transform:translateY(-10px); }
  100% { transform:translateY(  0px); }
}

.footer {
  position: fixed;
  bottom: 0;
  padding: 3px;
}
</style>
</head>
<body>
<div id="app" @mousemove="onMouseMoved" @touchmove="onMouseMoved">
  <div class="container" :style="rotation">
    <img class="bg" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230542.jpg">
    <img class="water front" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230600.jpg">
    <img class="water side left" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230600.jpg">
    <img class="water side right" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230600.jpg">
    <img class="water top" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230600.jpg">
    <img class="ground" src="https://cdn-ak.f.st-hatena.com/images/fotolife/d/dala/20180713/20180713230550.jpg">
    <img v-for="fish in fishes" class="fish" :style="fishStyle(fish)" :src="fish.image">
  </div>
  <div class="footer">
    <button class="btn btn-default" @click="fishes.push(generateFish())"></button>
  </div>
</div>
</body>
</html>