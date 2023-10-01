global.octaves = 2;

function generateVector(_seed, _x, _y) {
    var _new_seed = _seed + _x*65336 + _y;
	random_set_seed(_new_seed);
    var _vector = random(1);
    return _vector
}

function noise(_seed, _x, _y) {
    
	// Get bottom left coordinate of the current grid a point is in
    var _gridX = floor(_x);
    var _gridY = floor(_y);
    
	// Gets how far in a point is within a vector
    var _xOff = _x - floor(_x);
    var _yOff = _y - floor(_y);
    
    // generate all of the grid vectors
	var _tl, _tr, _bl, _br;
    _tl = generateVector(_seed, _gridX, _gridY+1);
    _tr = generateVector(_seed, _gridX+1, _gridY+1);
    _bl = generateVector(_seed, _gridX, _gridY);
    _br = generateVector(_seed, _gridX+1, _gridY);
    
    var _topX = lerp(_tl, _tr, _xOff);
    var _bottomX = lerp(_bl, _br, _xOff);
    var _point = lerp(_bottomX, _topX, _yOff);
    return _point;
}

function noise_octave(_seed, _x, _y, _octaves = 1) {
	
	var _point = noise(_seed, _x, _y);
	
	for (var _octave = 1; _octave < _octaves; _octave++) {
		
		var _newNoise = noise(_seed + _octave *100.123, _x, _y) - 0.5; // gets a scale between -0.5 and 0.5
		_newNoise *= (1/_octave); // This decreases the influence of a noise every octave
		_point += _newNoise;
	}
	
	return _point;
}