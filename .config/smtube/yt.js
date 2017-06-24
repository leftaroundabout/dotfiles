// Version: 2017-01-10

// Obsolete function
function aclara(a) {
	var d = a.split(".");
	var id = d[0].length + "." + (a.length - d[0].length - 1);

	if (id == "44.40") {
		return aclara_f(a);
	}
	return "";
}

function aclara_p(a,p) {
	var d = a.split(".");
	var id = d[0].length + "." + (a.length - d[0].length - 1);

	if (p == "en_US-vflsagga9") {
		return aclara_f(a);
	}
	return "";
}

function aclara_f(a) {
	a=a.split("");
	Fi.qC(a,3);
	Fi.i9(a,43);
	Fi.GZ(a,23);
	Fi.i9(a,24);
	Fi.GZ(a,33);
	Fi.GZ(a,51);
	Fi.qC(a,1);
	Fi.i9(a,76);
	Fi.GZ(a,26);
	return a.join("");
}

var Fi = {GZ:function(a,b){var c=a[0];a[0]=a[b%a.length];a[b]=c},
qC:function(a,b){a.splice(0,b)},
i9:function(a){a.reverse()} };

// A: NDQuNDA=
// B: ZW5fVVMtdmZsc2FnZ2E5
// C: MjAxNy0wMS0xMA==
// D: c3RzPTE3MTc1
// E: Rmk=
