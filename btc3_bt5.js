function DienTich(cd,cr){
	var cd = parseInt(document.getElementById("dai").value);
	var cr = parseInt(document.getElementById("rong").value);
	if(cd<=0 || cr<=0 || cd<cr || !cd || !cr)
	{
		alert("Lỗi nhập dữ liệu...");
		document.getElementById("dai").value = "";
		document.getElementById("rong").value = "";
	}
	else{
		var dt = document.getElementById("ket_qua");
		var kq = cd * cr;
		dt.value = kq;
	}
}