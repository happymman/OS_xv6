package wellDressedMan.weather2clothes.controller;

import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import wellDressedMan.weather2clothes.domain.Region;
import wellDressedMan.weather2clothes.domain.Weather;
import wellDressedMan.weather2clothes.dto.WeatherResponse;
import wellDressedMan.weather2clothes.dto.WeatherResponseDTO;
import wellDressedMan.weather2clothes.service.WeatherService;
//import wellDressedMan.weather2clothes.service.WeatherService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/weather")
@RequiredArgsConstructor
public class WeatherApiController {
    private final EntityManager em;
    @Autowired
    private WeatherService weatherService;

    @Value("${weatherApi.serviceKey}")
    private String serviceKey;

    @GetMapping
    @Transactional
    public ResponseEntity<WeatherResponseDTO> getTotalInfo(@RequestParam Long regionId) throws UnsupportedEncodingException, IOException {

        // 1. 날씨 정보를 요청한 지역 조회
        Region region = em.find(Region.class, regionId);

        Map<String, Object> result =  weatherService.getRegionWeather(region);
//        weatherService.getFashion();

        //List<Weather.Short> weatherUltraShort 세팅
        //List<Weather.Short> weatherShort 세팅
        //List<Weather.Mid> weatherMid 세팅

//        //WeatherResponse 세팅
//        WeatherResponse response = ;
//
//        //WeatherResponseDTO 세팅
//        WeatherResponseDTO dto = WeatherResponseDTO.builder()
//                    .weatherResponse(response)
//                    .message("날씨 정보를 불러오는 중 오류가 발생했습니다").build();
//        return ResponseEntity.ok(dto);
        return null;

        /*
        2-1.초단기실황 조회
            - 데이터 보유 확인 - 요청url설정+요청+날씨저장
        2-2.초단기예보 조회
            - 데이터 보유 확인 - 요청url설정+요청+날씨저장
        2-3.단기예보 조회
            - 데이터 보유 확인 - 요청url설정+요청+날씨저장
        2-4.중기예보 조회
            - 데이터 보유 확인 - 요청url설정+요청+날씨저장
        2-5.대기오염정보 조회
            - 데이터 보유 확인 - 요청url설정+요청+날씨저장

        3.패션추천

        4.res 세팅
            - USN Weather 세팅
                setUSFWeather((short)region.getId().intValue());
            - USF Weather 세팅
            - VF Weather 세팅
            - MVF weather 세팅
            - 미세먼지 weather 세팅

            - 패션추천데이터 세팅
        5.res 전송
        */


        // 1. 날씨 정보를 요청한 지역 조회
//        Region region = em.find(Region.class, regionId);

//        log.info("API 요청 발송 >>> 지역: {}, 연월일: {}, 시각: {}", region, yyyyMMdd, hourStr);

//
//            Double temp = null;
//            Double humid = null;
//            Double rainAmount = null;
//
//            //특정 지역의 날씨(with 기준시간) 저장
//            WeatherResponse weatherResponse = new WeatherResponse(temp, rainAmount, humid, currentChangeTime);
//            //Region테이블에 저장
//            region.updateRegionWeather(weatherResponse); // DB 업데이트
//            WeatherResponseDTO dto = WeatherResponseDTO.builder()
//                    .weatherResponse(weatherResponse)
//                    .message("OK").build();
//            return ResponseEntity.ok(dto);
//
//        } catch (IOException e) {
//            WeatherResponseDTO dto = WeatherResponseDTO.builder()
//                    .weatherResponse(null)
//                    .message("날씨 정보를 불러오는 중 오류가 발생했습니다").build();
//            return ResponseEntity.ok(dto);
//        }

    }
    /*
    */

}