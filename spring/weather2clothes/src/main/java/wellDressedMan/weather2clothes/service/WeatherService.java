package wellDressedMan.weather2clothes.service;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import wellDressedMan.weather2clothes.domain.Region;
import wellDressedMan.weather2clothes.domain.Weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WeatherService {

    private static Map<short[], short[]> midCode = new HashMap<>();
    private static Map<short[], short[][]> weatherUltraShort = new HashMap<>(); // key : 지역고유번호, 발표날짜, 발표시각
                                                                                // value : 예보날짜, 예보시간, 기온, 강수량, 풍속, 습도, 강수형태+하늘, 강수확률
    private static Map<short[], short[][]> weatherShort = new HashMap<>(); // key : 지역고유번호, 발표날짜, 발표시각
                                                                           // value : 예보날짜, 예보시간, 기온, 강수량, 풍속, 습도, 강수형태+하늘, 강수확률
    private static Map<short[], short[][]> weatherMidLand = new HashMap<>(); //	key : 지역고유번호, 발표날짜, 발표시각
                                                                             // value : 예보날짜,      오전강수확률+오후강수확률
    private static Map<short[], short[][]> weatherMidTemp = new HashMap<>(); // key : 지역고유번호, 발표날짜, 발표시각
                                                                            // value : 예보날짜,      최저기온, 최고온도
    @Value("${weatherApi.serviceKey}")
    private String serviceKey;

    //public ResponseEntity<WeatherResponseDTO> getRegionWeather(Region region) throws IOException{ 테스트용
    public Map<String, Object> getRegionWeather(Region region) throws IOException{
        getUSN(region, serviceKey);
        getUSF(region, serviceKey);
        getVF(region, serviceKey);
        getMFLand(region, serviceKey);
        getMFTemp(region, serviceKey);

        List<Weather.UltraShort> WUS = setWeatherUltraShort((short)(region.getId().intValue())); //List<Weather.Short> weatherUltraShort 세팅
        List<Weather.Short> WS = setWeatherShort((short)(region.getId().intValue())); //List<Weather.Short> weatherShort 세팅
//        List<Weather.Mid> WM = setWeatherMid((short)(region.getId().intValue())); //List<Weather.Mid> weatherMid 세팅

        //map.put
        Map<String, Object> result = new HashMap<>();
        result.put("weatherUltraShort", WUS);
        result.put("weatherShort", WS);
//        result.put("weatherMid", WM);

        System.out.println();
        return result;
    }

    /*
    public ResponseEntity<WeatherResponseDTO> getFashion(@RequestParam Long regionId){

    }
     */

    static void getUSN(Region region, String serviceKey) throws IOException {
        //1.데이터 보유 확인
        if(haveAlready((short)region.getId().intValue(), "USN")) return;
        //2.요청 url설정
        URL url = setURL(serviceKey, region.getNx(), region.getNy(), "USN");
        //3.요청
        String resData = requestWeather(url);
        //4.날씨저장
        saveWeatherForUSN(resData, (short)region.getId().intValue());
    };

    static void getUSF(Region region, String serviceKey) throws IOException{
        //1.데이터 보유 확인
        if(haveAlready((short)region.getId().intValue(), "USF")) return;
        //2.요청 url설정
        URL url = setURL(serviceKey, region.getNx(), region.getNy(), "USF");
        //3.요청
        String resData = requestWeather(url);
        //4.날씨저장
        saveWeatherForUSF(resData, (short)region.getId().intValue());
    };


    static void getVF(Region region, String serviceKey) throws IOException{
        //1.데이터 보유 확인
        if(haveAlready((short)region.getId().intValue(), "VF")) return;
        //2.요청 url설정
        URL url = setURL(serviceKey, region.getNx(), region.getNy(), "VF");
        //3.요청
        String resData = requestWeather(url);
        //4.날씨저장
        saveWeatherForVF(resData, (short)region.getId().intValue());
    };

    static void getMFLand(Region region, String serviceKey) throws IOException{
        //1.데이터 보유 확인
        if(haveAlready((short)region.getId().intValue(), "MFL")) return;
        //2.요청 url설정
        URL url = setURL(serviceKey, region.getNx(), region.getNy(), "MFL");
        //3.요청
        String resData = requestWeather(url);
        //4.날씨저장
//        saveWeatherForMFLand(resData, (short)region.getId().intValue());
    };

    static void getMFTemp(Region region, String serviceKey) throws IOException{
        //1.데이터 보유 확인
        if(haveAlready((short)region.getId().intValue(), "MFT")) return;
        //2.요청 url설정
        URL url = setURL(serviceKey, region.getNx(), region.getNy(), "MFT");
        //3.요청
        String resData = requestWeather(url);
        //4.날씨저장
//        saveWeatherForMFTemp(resData, (short)region.getId().intValue());
    };
    static boolean haveAlready(short regionId, String type){
        //기준시각 설정
        short[] stdTime = null;
        switch(type){
            case "USN" :
                stdTime = setStdTimeKeyForUSN(regionId);
                //해당 지역날씨, 기준시각 데이터 있는지 확인
                if(!isExists(weatherUltraShort, stdTime)) return false;
                break;
            case "USF" :
                stdTime = setStdTimeKeyForUSF(regionId);
                //해당 지역날씨, 기준시각 데이터 있는지 확인
                if(!isExists(weatherUltraShort, stdTime)) return false;
                break;
            case "VF" :
                stdTime = setStdTimeKeyForVF(regionId);
                //해당 지역날씨, 기준시각 데이터 있는지 확인
                if(!isExists(weatherShort, stdTime)) return false;
                break;
            case "MFL" : //중기육상조회
                stdTime = setStdTimeKeyForMF(regionId);
                //해당 지역날씨, 기준시각 데이터 있는지 확인
                if(!isExists(weatherMidLand, stdTime)) return false;
                break;
            case "MFT" : //중기기온조회
                stdTime = setStdTimeKeyForMF(regionId);
                //해당 지역날씨, 기준시각 데이터 있는지 확인
                if(!isExists(weatherMidTemp, stdTime)) return false;
                break;
        }
        return true;
    };

    static boolean isExists(Map<short[], short[][]> weatherMap, short[] stdTime){
        for(short[] searchKey : weatherMap.keySet()){
            if(equals(searchKey, stdTime)) return true;
        }
        return false;
    }

    //동등성 비교 for short[]
    public static boolean equals(short[] a, short[] b) {
        if (a.length != b.length) {
            return false;
        }

        for (int i = 0; i < a.length; i++) {
            if (a[i] != b[i]) {
                return false;
            }
        }
        //원소의 값이 전부다 같으면 -> 동일하다고 판단
        return true;
    }

    static short[] setStdTimeKeyForUSN(short regionId){
        LocalDateTime now = LocalDateTime.now();
        System.out.println(now.format(DateTimeFormatter.ofPattern("yyyy.MM.dd:HH:mm")));

        if(now.getMinute() < 40){
            now = now.minusHours(1); //130 ->030
        }

        short hour = (short)now.getHour();
        short min = 0;

        System.out.println(now.format(DateTimeFormatter.ofPattern("yyyy.MM.dd:HH:mm")));
        short baseDate = Short.parseShort(now.format(DateTimeFormatter.ofPattern("MMdd")));
        short baseTime = (short)(hour*100+min);

        short[] stdTime = new short[]{regionId, baseDate, baseTime};
        return stdTime;
    }

    static short[] setStdTimeKeyForUSF(short regionId){
        LocalDateTime now = LocalDateTime.now();
        if(now.getMinute() < 45){
            now = now.minusHours(1);
        }

        short hour = (short)now.getHour();
        short min = 30;

        short baseDate = Short.parseShort(now.format(DateTimeFormatter.ofPattern("MMdd")));
        short baseTime = (short)(hour*100+min);

        short[] stdTime = new short[]{regionId, baseDate, baseTime};
        return stdTime;
    }

    static short[] setStdTimeKeyForVF(short regionId){
        LocalDateTime now = LocalDateTime.now();
        /*
        2,5,8,11,14,17,20,23시 발표자료를
        2:10,5:10,8:10,11:10,14:10,17:10,20:10,23:10 부터 제공
         */
        now = now.minusMinutes(10);
        if((now.getHour()+1)%3!=0){
            now = now.minusHours((now.minusMinutes(10).getHour()+1)%3); //130 ->030
        }

        short hour = (short)now.getHour();
        short min = 0;

        short baseDate = Short.parseShort(now.format(DateTimeFormatter.ofPattern("MMdd")));
        short baseTime = (short)(hour*100+min);
        short[] stdTime = new short[]{regionId, baseDate, baseTime};
        return stdTime;
    }

    static short[] setStdTimeKeyForMF(short regionId){
        LocalDateTime now = LocalDateTime.now();
        /*
        6,18시 발표자료를
        6:00, 18:00 부터 제공(확인 필요)(API명세에는 따로 언급X)
         */

        if((now.getHour()+6)%12!=0){
            now = now.minusHours((now.getHour()+6)%12); //기준시각을 6:00, 18:00으로 조정
        }

        short hour = (short)now.getHour();
        short min = 0;

        short baseDate = Short.parseShort(now.format(DateTimeFormatter.ofPattern("MMdd")));
        short baseTime = (short)(hour*100+min);
        short[] stdTime = new short[]{regionId, baseDate, baseTime};
        return stdTime;
    }

    static URL setURL(String serviceKey, int nx, int ny, String type) throws UnsupportedEncodingException, MalformedURLException {
        StringBuilder urlBuilder =  new StringBuilder("http://apis.data.go.kr/1360000/");

        //초단기실황, 초단기예보, 단기예보 URL 패턴 -> &base_date=20210628&base_time=0630&nx=55&ny=127
        //중기육상조회, 중기기온조회 URL 패턴 -> &regId=11B00000&tmFc=201310171800
        String[] stdTimeStrs=new String[2];
        String stdTimeStr;
        switch(type){
            case "USN" :
                urlBuilder.append("VilageFcstInfoService_2.0/getUltraSrtNcst");
                stdTimeStrs=setStdTimeStringForUSN();
                break;
            case "USF" :
                urlBuilder.append("VilageFcstInfoService_2.0/getUltraSrtFcst");
                stdTimeStrs=setStdTimeStringForUSF();
                break;
            case "VF" :
                urlBuilder.append("VilageFcstInfoService_2.0/getVilageFcst");
                stdTimeStrs=setStdTimeStringForVF();
                break;
            case "MFL" :
                urlBuilder.append("MidFcstInfoService/getMidLandFcst");
                stdTimeStr=setStdTimeStringForMF();
                break;
            case "MFT" :
                urlBuilder.append("MidFcstInfoService/getMidTa");
                stdTimeStr=setStdTimeStringForMF();
                break;
        }


        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/

        switch (type){
            case "USN" :
            case "USF" :
            case "VF" :
                String yyyyMMddStd = stdTimeStrs[0];
                String hourStr = stdTimeStrs[1];

                urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode(yyyyMMddStd, "UTF-8")); /*‘21년 6월 28일 발표*/
                urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode(hourStr, "UTF-8")); /*06시 발표(정시단위) */
                urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(nx), "UTF-8")); /*예보지점의 X 좌표값*/
                urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(ny), "UTF-8")); /*예보지점의 Y 좌표값*/
                break;
            case "MFL" :
            case "MFT" :
//                String yyyyMMddStd = stdTimeStr;

//                urlBuilder.append("&" + URLEncoder.encode("regId", "UTF-8") + "=" + URLEncoder.encode(yyyyMMddStd, "UTF-8")); /*‘21년 6월 28일 발표*/
//                urlBuilder.append("&" + URLEncoder.encode("tmFc", "UTF-8") + "=" + URLEncoder.encode(hourStr, "UTF-8")); /*06시 발표(정시단위) */
                break;
        }

        URL url = new URL(urlBuilder.toString());
        return url;
    };

    static String[] setStdTimeStringForUSN(){
        LocalDateTime now = LocalDateTime.now();
        System.out.println(now.format(DateTimeFormatter.ofPattern("yyyy.MM.dd:HH:mm")));

        if(now.getMinute() < 40){
            now = now.minusHours(1); //130 ->030
        }

        String hour = String.valueOf(now.getHour());
        hour = hour.length()<2 ? "0"+hour : hour;
        String min = "00";

        String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String baseTime = hour+min;

        String[] stdTimeString = new String[]{baseDate, baseTime};
        return stdTimeString;
    };

    static String[] setStdTimeStringForUSF(){
        LocalDateTime now = LocalDateTime.now();
        System.out.println(now.format(DateTimeFormatter.ofPattern("yyyy.MM.dd:HH:mm")));

        if(now.getMinute() < 45){
            now = now.minusHours(1); //130 ->030
        }

        String hour = String.valueOf(now.getHour());
        hour = hour.length()<2 ? "0"+hour : hour;
        String min = "30";

        String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String baseTime = hour+min;

        String[] stdTimeString = new String[]{baseDate, baseTime};
        return stdTimeString;
    };

    static String[] setStdTimeStringForVF(){
        LocalDateTime now = LocalDateTime.now();

        now = now.minusMinutes(10);
        if((now.getHour()+1)%3!=0){
            now = now.minusHours((now.minusMinutes(10).getHour()+1)%3); //130 ->030
        }

        String hour = String.valueOf(now.getHour());
        hour = hour.length()<2 ? "0"+hour : hour;
        String min = "00";

        String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String baseTime = hour+min;

        String[] stdTimeString = new String[]{baseDate, baseTime};
        return stdTimeString;
    };

    static String setStdTimeStringForMF(){
        LocalDateTime now = LocalDateTime.now();
        /*
        6,18시 발표자료를
        6:00, 18:00 부터 제공(확인 필요)(API명세에는 따로 언급X)
         */
        if((now.getHour()+6)%12!=0){
            now = now.minusHours((now.getHour()+6)%12); //기준시각을 6:00, 18:00으로 조정
        }

        String hour = String.valueOf(now.getHour());
        hour = hour.length()<2 ? "0"+hour : hour;
        String min = "00";

        String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String baseTime = hour+min;

        String stdTimeString = baseDate+baseTime;
        return stdTimeString;
    };

    static String requestWeather(URL url) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String data = sb.toString();

        return data;
    };

    static void saveWeatherForUSN(String resData, short regionId){
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
            baseDate = (short) (obj.getInt("baseDate") % 1000);
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

    static void saveWeatherForUSF(String resData, short regionId) {
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
        baseDate = (short) (firstObj.getInt("baseDate") % 1000); // 값 경우의수(종류) :
        key[1] = baseDate;
        baseTime = (short) (firstObj.getInt("baseTime")); // 값 경우의수(4종류) : 0, 30, 100, 2330
        key[2] = baseTime;

        int row=0;
        for (int jsonIndex = 0; jsonIndex < jArray.length(); jsonIndex++) {
            JSONObject obj = jArray.getJSONObject(jsonIndex);
            System.out.println("obj: " + obj);

            fcstDate = (short) (obj.getInt("fcstDate") % 1000);
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

    static void saveWeatherForVF(String resData, short regionId) {
        JSONObject jObject = new JSONObject(resData);
        JSONObject response = jObject.getJSONObject("response");
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
        baseDate = (short) (firstObj.getInt("baseDate") % 1000);
        key[1] = baseDate;
        baseTime = (short) (firstObj.getInt("baseTime"));
        key[2] = baseTime;

        int row=0;
        for (int jsonIndex = 0; jsonIndex < jArray.length(); jsonIndex++) {
            if(row==25) break; // 필요한 데이터는 현재시각+23시간후 날씨까지이고 단기예보 발표시각이 3시간단위(2:00->5:00)인 것을 고려하여 25시간후까지만 저장

            JSONObject obj = jArray.getJSONObject(jsonIndex);
            System.out.println("obj: " + obj);

            if(jsonIndex%12==0){
                fcstDate = (short) (obj.getInt("fcstDate") % 1000);
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

    static List<Weather.UltraShort> setWeatherUltraShort(short regionId){
        List<Weather.UltraShort> result = new ArrayList<>();

        short[] searchKeyForUSN = setStdTimeKeyForUSN(regionId);
        for(short[] key : weatherUltraShort.keySet()){
            if(equals(searchKeyForUSN, key)){
                short[][] values = weatherUltraShort.get(key);

                for(int i=0;i<1;i++){ //초단기실황 데이터 1개 Weather.Short 객체 세팅
                    short[] value = values[i];
                    Weather.UltraShort item = Weather.UltraShort.builder()
                            .fcstDate(value[0])
                            .fcstTime(value[1])
                            .temp(value[2])
                            .rainAmount(value[3])
                            .windSpeed(value[4])
                            .humid(value[5])
                            .sky(value[6])
                            .build();
                    result.add(item);
                }
            }
        }

        short[] searchKeyForUSF = setStdTimeKeyForUSF(regionId);
        for(short[] key : weatherUltraShort.keySet()){
            if(equals(searchKeyForUSF, key)){
                short[][] values = weatherUltraShort.get(key);

                for(int i=0;i<6;i++){
                    short[] value = values[i]; //초단기예보 데이터 6개 Weather.Short 객체 세팅
                    Weather.UltraShort item = Weather.UltraShort.builder()
                            .fcstDate(value[0])
                            .fcstTime(value[1])
                            .temp(value[2])
                            .rainAmount(value[3])
                            .windSpeed(value[4])
                            .humid(value[5])
                            .sky(value[6])
                            .build();
                    result.add(item);
                }
            }
        }

        return result;
    };
    static List<Weather.Short> setWeatherShort(short regionId){
        List<Weather.Short> result = new ArrayList<>();

        short[] searchKeyForVF = setStdTimeKeyForVF(regionId);
        for(short[] key : weatherShort.keySet()){
            if(equals(searchKeyForVF, key)){
                short[][] values = weatherShort.get(key);

                for(int i=0;i<25;i++){
                    short[] value = values[i]; //Weather.Short 세팅
                    Weather.Short item = Weather.Short.builder()
                            .fcstDate(value[0])
                            .fcstTime(value[1])
                            .temp(value[2])
                            .rainAmount(value[3])
                            .windSpeed(value[4])
                            .humid(value[5])
                            .sky(value[6])
                            .rainPercentage(value[7])
                            .build(); // builder를 통해 객체 생성
                    result.add(item);
                }
            }
        }
        return result;
    };

//    static List<Weather.Mid> setWeatherMid(short regionId){
//
//    };
}
