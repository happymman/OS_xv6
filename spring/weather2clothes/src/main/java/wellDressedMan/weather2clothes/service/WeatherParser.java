package wellDressedMan.weather2clothes.service;

import org.json.JSONArray;
import org.json.JSONObject;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static wellDressedMan.weather2clothes.service.WeatherRequest.setStdTimeStringForMF;
import static wellDressedMan.weather2clothes.service.WeatherService.*;

public class WeatherParser {
    static void parseWeatherDataForUSN(String resData, short regionId){
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray jArray = items.getJSONArray("item");

        short baseDate, baseTime;
        short fcstDate, fcstTime, temp, rainAmount, windSpeed, humid=0, rainType= 0, rainPercentage;

        short[] key = new short[3]; //regionId, 발표날짜, 발표시각
        short[][] value = new short[1][8]; //'예보날짜', '예보시각', '기온' '강수량' '풍속' '습도' '강수형태+하늘' 강수확률. ''-> 초단기실황조회에서 가져올 정보


        for(int i = 0; i < jArray.length(); i++) {
            JSONObject obj = jArray.getJSONObject(i);
            System.out.println("obj: " + obj);

            key[0] = regionId;
            baseDate = (short) (obj.getInt("baseDate") % 10000); //뒤 네자리 추출
            key[1] = baseDate;
            baseTime = (short) (obj.getInt("baseTime"));
            key[2] = baseTime;
            fcstDate = baseDate;
            value[0][0] = fcstDate;
            fcstTime = baseTime;
            value[0][1] = fcstTime;

            String category = obj.getString("category");
            //가져오고자하는 값이 아니면 등록하지 않는다.
            if(!(category.equals("T1H") || category.equals("RN1")|| category.equals("WSD")|| category.equals("REH")|| category.equals("PTY"))) continue;
            switch (category) {
                case "T1H": //기온
                    temp = (short)(obj.getDouble("obsrValue")*10);
                    value[0][2] = temp;
                    break;
                case "RN1": //강수량
                    String rainAmountData = obj.getString("obsrValue");
                    switch (rainAmountData) {
                        case "0" :
                            rainAmount = 0;
                            break;
                        case "1.0mm 미만":
                            rainAmount = 1; //현재 임의로 정한 값
                            break;
                        case "30.0~50.0mm":
                            rainAmount = 40; //현재 임의로 정한 값
                            break;
                        case "50.0mm 이상":
                            rainAmount = 65; //현재 임의로 정한 값
                            break;
                        default:
                            rainAmount = 15; //현재 임의로 정한 값
                    }
                    value[0][3] = rainAmount;
                    break;
                case "WSD": //풍속
                    windSpeed = (short)(obj.getDouble("obsrValue")*10);
                    value[0][4] = windSpeed;
                    break;
                case "REH": //습도
                    humid = (short)((obj.getInt("obsrValue")));
                    value[0][5] = humid;
                    break;
                case "PTY": //강수형태(+하늘)
                    rainType = (short) obj.getInt("obsrValue"); //초단기실황조회에서는 "SKY" category가 없음
                    value[0][6] += rainType*10;
            }
        }
        weatherUltraShort.put(key, value);
    }

    static void parseWeatherDataForUSF(String resData, short regionId) {
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray jArray = items.getJSONArray("item");

        short baseDate, baseTime;
        short fcstDate, fcstTime, temp, rainAmount, windSpeed, humid=0, rainType, sky = 0, rainPercentage;


        short[] key = new short[3]; //regionId, 발표날짜, 발표시각
        short[][] value = new short[6][8]; //'예보날짜', '예보시각', '기온' '강수량' '풍속' '습도' '강수형태+하늘' 강수확률

        //키 설정
        JSONObject firstObj = jArray.getJSONObject(0);
        key[0] = regionId;
        baseDate = (short) (firstObj.getInt("baseDate") % 10000); // 뒤 네자리 추출 -  값 경우의수(종류) :
        key[1] = baseDate;
        baseTime = (short) (firstObj.getInt("baseTime")); // 값 경우의수(4종류) : 0, 30, 100, 2330
        key[2] = baseTime;

        int row=0;
        for (int jsonIndex = 0; jsonIndex < jArray.length(); jsonIndex++) {
            JSONObject obj = jArray.getJSONObject(jsonIndex);
            System.out.println("obj: " + obj);

            fcstDate = (short) (obj.getInt("fcstDate") % 10000); //뒤 네자리 추출
            value[row][0] = fcstDate;
            fcstTime = (short) (obj.getInt("fcstTime"));
            value[row][1] = fcstTime;

            String category = obj.getString("category");
            //가져오고자하는 값이 아니면 등록하지 않는다.
            if(!(category.equals("T1H") || category.equals("RN1")|| category.equals("WSD")|| category.equals("REH")|| category.equals("PTY")|| category.equals("SKY")|| category.equals("POP"))) continue;
            switch (category) {
                case "T1H": //기온
                    temp = (short)(obj.getDouble("fcstValue")*10);
                    value[row][2] = temp;
                    row++;
                    break;
                case "RN1": //강수량
                    String rainAmountData = obj.getString("fcstValue");
                    switch (rainAmountData) {
                        case "강수없음" : //초단기예보에서는 "강수없음", 초단기실황에서는 "0"
                            rainAmount = 0;
                            break;
                        case "1.0mm 미만":
                            rainAmount = 1; //현재 임의로 정한 값
                            break;
                        case "30.0~50.0mm":
                            rainAmount = 40; //현재 임의로 정한 값
                            break;
                        case "50.0mm 이상":
                            rainAmount = 65; //현재 임의로 정한 값
                            break;
                        default:
                            rainAmount = 15; //현재 임의로 정한 값
                    }
                    value[row][3] = rainAmount;
                    row++;
                    break;
                case "WSD": //풍속
                    windSpeed = (short)(obj.getDouble("fcstValue")*10);
                    value[row][4] = windSpeed;
                    row++;
                    break;
                case "REH": //습도
                    humid = (short)((obj.getInt("fcstValue")));
                    value[row][5] = humid;
                    row++;
                    break;
                case "PTY": //강수형태(+하늘)
                    rainType = (short) obj.getInt("fcstValue"); //초단기실황조회에서는 "SKY" category가 없음
                    value[row][6] += (short)(rainType*10);
                    row++;
                    break;
                case "SKY": //(강수형태+)하늘
                    sky = (short) obj.getInt("fcstValue");
                    value[row][6] += sky;
                    row++;
                    break;
                case "POP": //강수확률
                    rainPercentage = (short) obj.getInt("fcstValue");
                    value[row][7] = rainPercentage;
                    row++;
                    break;
            }
            if(row%6==0) row=0;
        }
        weatherUltraShort.put(key, value);
    }

    static void parseWeatherDataForVF(String resData, short regionId) {
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
        /*
            예외 발생 가능
            response = {"header":{"resultCode":"03","resultMsg":"NO_DATA"}} - 발생상황 : 일시적 발생 가능 오류
            response = {"header":{"resultCode":"99","resultMsg":"UNKOWN_ERROR"}} //에러메세지는 다를수도 있음(현재 실제 발생하는 resultMsg와 api명세에 적혀있는 메세지가 다른 상태(실제 : NO_DATA, 명세 : NODATA_ERROR));
            response = {"header":{"resultCode":"21","resultMsg":"TEMPORARILY_DISABLE_THE_SERVICEKEY_ERROR"}} - 발생상황 : 일시적 발생 가능 오류
         */

        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray jArray = items.getJSONArray("item");

        short baseDate, baseTime;
        short fcstDate, fcstTime, temp, rainAmount, windSpeed, humid=0, rainType = 0, sky = 0, rainPercentage;

        short[] key = new short[3]; //regionId, 발표날짜, 발표시각
        short[][] value = new short[25][8]; //'예보날짜', '예보시각', '(1시간)기온' '강수량' '풍속' '습도' '강수형태+하늘' 강수확률

        //키 설정
        JSONObject firstObj = jArray.getJSONObject(0);
        key[0] = regionId;
        baseDate = (short) (firstObj.getInt("baseDate") % 10000); //뒤 4자리 추출
        key[1] = baseDate;
        baseTime = (short) (firstObj.getInt("baseTime"));
        key[2] = baseTime;

        int row=0;
        for (int jsonIndex = 0; jsonIndex < jArray.length(); jsonIndex++) {
            if(row==25) break; // 필요한 데이터는 현재시각+23시간후 날씨까지이고 단기예보 발표시각이 3시간단위(2:00->5:00)인 것을 고려하여 25시간후까지만 저장

            JSONObject obj = jArray.getJSONObject(jsonIndex);
            System.out.println("obj: " + obj);

            if(jsonIndex%12==0){
                fcstDate = (short) (obj.getInt("fcstDate") % 10000);
                value[row][0] = fcstDate;
                fcstTime = (short) (obj.getInt("fcstTime"));
                value[row][1] = fcstTime;
            }

            String category = obj.getString("category");
            //해당카테 고리일때만 switch문을 실행한다.
            if(category.equals("TMP") || category.equals("PCP")|| category.equals("WSD")|| category.equals("REH")|| category.equals("PTY")|| category.equals("SKY")|| category.equals("POP")){
                switch (category) {
                    case "TMP": //(1시간) 기온
                        temp = (short)(obj.getDouble("fcstValue")*10);
                        value[row][2] = temp;
                        break;
                    case "PCP": //강수량
                        String rainAmountData = obj.getString("fcstValue");
                        switch (rainAmountData) {
                            case "0" :
                                rainAmount = 0;
                                break;
                            case "1.0mm 미만":
                                rainAmount = 1; //현재 임의로 정한 값
                                break;
                            case "30.0~50.0mm":
                                rainAmount = 40; //현재 임의로 정한 값
                                break;
                            case "50.0mm 이상":
                                rainAmount = 65; //현재 임의로 정한 값
                                break;
                            default:
                                rainAmount = 15; //현재 임의로 정한 값
                        }
                        value[row][3] = rainAmount;
                        break;
                    case "WSD": //풍속
                        windSpeed = (short)(obj.getDouble("fcstValue")*10);
                        value[row][4] = windSpeed;
                        break;
                    case "REH": //습도
                        humid = (short)((obj.getInt("fcstValue")));
                        value[row][5] = humid;
                        break;
                    case "PTY": //강수형태(+하늘)
                        rainType = (short)(obj.getInt("fcstValue")*10); //초단기실황조회에서는 "SKY" category가 없음
                        value[row][6] += rainType;
                        break;
                    case "SKY": //(강수형태+)하늘
                        sky = (short) obj.getInt("fcstValue");
                        value[row][6] += sky;
                        break;
                    case "POP": //강수확률
                        rainPercentage = (short) obj.getInt("fcstValue");
                        value[row][7] = rainPercentage;
                }
            }
            if(jsonIndex%12==11) row++; //0~11 반복한뒤 다음줄 채우기
        }
        weatherShort.put(key, value);
    }

    /*
        발표날짜 기준 3,4,5,6일후의 오전강수확률, 오후 강수확률 데이터를 추출해서 wheatherMid에 저장
        발표날짜 기준 1,2일후의 오전강수확률, 오후 강수확률 데이터는 단기예보로부터 추출해서 wheatherMid에 저장
    */
    static void parseWeatherDataForMFL(String resData, short regionId) { //
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray jArray = items.getJSONArray("item");

        short baseDate, baseTime;
        short fcstDate,           rainAm, rainPm, skyAm, skyPm;

        short[] key = new short[3]; //regionId, 발표날짜, 발표시각
        short[][] value = new short[4][5]; //'예보날짜',       , 오전강수확률, 오후강수확률, 오전하늘상태, 오후하늘상태

        String baseDateTime = setStdTimeStringForMF(); //ex : 202308270600

        //키 설정
        key[0] = regionId;
        baseDate = (short) (Long.parseLong(baseDateTime)%100000000/10000); //뒤 5~8번째 숫자 추출 -> 827
        key[1] = baseDate;
        baseTime = (short) (Long.parseLong(baseDateTime) % 10000);//뒤 4자리 추출 -> 600
        key[2] = baseTime;

        JSONObject obj = jArray.getJSONObject(0);
        System.out.println("obj: " + obj);

        //value설정
        setFcstDate(value); //value배열에 예보날짜 정보 세팅

        for (int day = 3; day <= 6; day++) {
            //오전, 오후 강수확률 정보 parsing
            String keyForRainAm = "rnSt" + day + "Am";
            String keyForRainPm = "rnSt" + day + "Pm";
            rainAm = (short) obj.getInt(keyForRainAm);;
            rainPm=(short) obj.getInt(keyForRainPm);;
            value[day - 3][1] = rainAm;
            value[day - 3][2] = rainPm;

            //오전, 오후 하늘상태 정보 parsing
            String keyForSkyAm = "wf" + day + "Am";
            String keyForSkyPm = "wf" + day + "Pm";
            skyAm = changeToWeatherCode(obj.getString(keyForSkyAm));
            skyPm = changeToWeatherCode(obj.getString(keyForSkyPm));
            value[day - 3][3] =skyAm;
            value[day - 3][4] =skyPm;
        }
        weatherMidLand.put(key, value);
    }

    static void parseWeatherDataForMFT(String resData, short regionId) { //
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray jArray = items.getJSONArray("item");

        short baseDate, baseTime;
        short fcstDate,           tempLowest, tempHighest;

        short[] key = new short[3]; //regionId, 발표날짜, 발표시각
        short[][] value = new short[4][3]; //'예보날짜',       ,최저기온, 최고기온

        String baseDateTime = setStdTimeStringForMF(); //ex : 202308270600

        //키 설정
        key[0] = regionId;
        baseDate = (short) (Long.parseLong(baseDateTime)%100000000/10000); //뒤 5~8번째 숫자 추출 -> 827
        key[1] = baseDate;
        baseTime = (short) (Long.parseLong(baseDateTime) % 10000);//뒤 4자리 추출 -> 600
        key[2] = baseTime;

        JSONObject obj = jArray.getJSONObject(0);
        System.out.println("obj: " + obj);

        //value설정
        setFcstDate(value); //value배열에 예보날짜 정보 세팅

        for (int day = 3; day <= 6; day++) {
            //오전, 오후 강수확률 정보 parsing
            String keyForTempLowest = "taMin" + day;
            String keyForTempHighest = "taMax" + day;
            tempLowest = (short) obj.getInt(keyForTempLowest);;
            tempHighest =(short) obj.getInt(keyForTempHighest);;
            value[day - 3][1] = tempLowest;
            value[day - 3][2] = tempHighest;
        }
        weatherMidTemp.put(key, value);
    }

    /* value배열에 예보날짜 정보 세팅 */
    static short[][] setFcstDate(short[][] value){
        LocalDate stdTime = getStdTimeForMF();

        for(int day=3;day<=6;day++){
            stdTime.plusDays(day); //day일 후의 날짜 계산 for(0731->0803, 1231->0103)
            short dayAfterN = Short.parseShort(stdTime.format(DateTimeFormatter.ofPattern("MMdd"))); //월일 정보만 추출
            value[day-3][0] = dayAfterN;
        }
        return value;
    };

    static LocalDate getStdTimeForMF(){
        LocalDateTime stdTime = LocalDateTime.now();
        /*
        6,18시 발표자료를
        6:00, 18:00 부터 제공(확인 필요)(API명세에는 따로 언급X)
         */
        if((stdTime.getHour()+6)%12!=0){
            stdTime = stdTime.minusHours((stdTime.getHour()+6)%12); //기준시각을 6:00, 18:00으로 조정
        }

        return stdTime.toLocalDate();
    }

    static short changeToWeatherCode(String skyAm){
        switch(skyAm){
            case "맑음" :
                return 1;
            case "구름많음" :
                return 3;
            case "구름많고 비" :
                return 31;
            case "구름많고 눈" :
                return 32;
            case "구름많고 비/눈" :
                return 33;
            case "구름많고 소나기" :
                return 34;
            case "흐림" :
                return 4;
            case "흐리고 비" :
                return 41;
            case "흐리고 눈" :
                return 42;
            case "흐리고 비/눈" :
                return 43;
            case "흐리고 소나기" :
                return 44;
            case "소나기" :
                return 5;
        }
        return -1; //error
    };

}
