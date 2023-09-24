package wellDressedMan.weather2clothes.dto;

import jakarta.persistence.Embeddable;
import lombok.*;
import wellDressedMan.weather2clothes.domain.Weather;

import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Embeddable //대응하는 DB테이블이 만들어지지 않도록
public class WeatherResponse {

    private List<Weather.UltraShort> weatherUltraShort;
    private List<Weather.Short> weatherShort;
    private List<Weather.Mid> weatherMid;

//    private Double temp; // 온도
//
//    private Double rainAmount; // 강수량
//
//    private Double humid; // 습도
//
//    private String lastUpdateTime; // 마지막 갱신 시각 (시간 단위)
}