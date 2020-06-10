package com.bitacademy.bms.Controller;


import com.bitacademy.bms.Service.Stock.StockSerivce;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Collection;
import java.util.HashMap;

@CrossOrigin("*")
@RequestMapping("/rest")
@RestController

public class RestItemController {

    @Autowired
    private StockSerivce stockSerivce;

    /**
     * Chart data Return (Json)
     */
    @RequestMapping(value = "/getJsonList",  produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Collection<HashMap<String, String>> getJsonList(@RequestParam(value = "name") String name)  {

        return stockSerivce.getChartDataList(name);
    }

}
