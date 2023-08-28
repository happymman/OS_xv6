package wellDressedMan.weather2clothes.service;

import wellDressedMan.weather2clothes.domain.Weather;

import java.util.ArrayList;
import java.util.List;

import static wellDressedMan.weather2clothes.service.WeatherService.weatherShort;
import static wellDressedMan.weather2clothes.service.WeatherService.weatherUltraShort;
import static wellDressedMan.weather2clothes.service.WeatherServiceUtility.*;

public class WeatherResponseSet {
    static List<Weather.UltraShort> createWeatherUltraShortResponseForRegion(short regionId){
        List<Weather.UltraShort> result = new ArrayList<>();

        short[] searchKeyForUSN = getStdTimeKeyForUSN(regionId);
        for(short[] key : weatherUltraShort.keySet()){
            if(arrEquals(searchKeyForUSN, key)){
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

        short[] searchKeyForUSF = getStdTimeKeyForUSF(regionId);
        for(short[] key : weatherUltraShort.keySet()){
            if(arrEquals(searchKeyForUSF, key)){
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
    static List<Weather.Short> createWeatherShortResponseForRegion(short regionId){
        List<Weather.Short> result = new ArrayList<>();

        short[] searchKeyForVF = getStdTimeKeyForVF(regionId);
        for(short[] key : weatherShort.keySet()){
            if(arrEquals(searchKeyForVF, key)){
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
