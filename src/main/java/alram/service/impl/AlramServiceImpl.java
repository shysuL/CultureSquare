package alram.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alram.dao.face.AlramDao;
import alram.dto.Alram;
import alram.service.face.AlramService;
import user.dto.User_table;

@Service
public class AlramServiceImpl implements AlramService{

	@Autowired private AlramDao alramDao;

	@Override
	public int getUserNoByUserNick(String usernick) {

		return alramDao.selectUserNo(usernick);
	}

	@Override
	public int getAlramCnt(int userno) {

		return alramDao.selectAlramCnt(userno);
	}

	@Override
	public void readAlram(Alram alram) {
		alramDao.updateAlramCheck(alram);

	}

	@Override
	public List<Alram> getAlramList(int userno) {
		return alramDao.selectAlramList(userno);
	}

}