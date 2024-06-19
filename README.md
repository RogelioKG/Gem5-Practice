# Gem5-Practice

112-02 CE3001 : Computer Organization Final Project

> [!NOTE]
> 模擬結果放在 `project/result` 目錄

> [!NOTE]
> 詳細 commit 在 `dev` 分支

## [▶️][0] Outline
+ [**Setting up the Project**][1]
+ [**Q2. Enable L3 cache**][2]
+ [**Grading Criteria**][3]
+ [**Common Options**][4]
+ [**Diagram**][5]


## [⬆️][0] Setting up the Project

1. **Environment**
    > Ubuntu 18.04 LTS

2. **Toolkits**
    ```bash
    sudo apt install build-essential git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python3-dev python3-six python libboost-all-dev pkg-config
    ```

3. **Install gem5**
    > [download gem5][gem5-file]

4. **Unzip and compile gem5**
    > [!CAUTION]
    > 在 gen5 目錄下

    > [!CAUTION]
    > 編譯之後位置就不能動 (編譯過程有使用到絕對路徑)
    ```bash
    scons build/X86/gem5.opt -j 4
    ```
    + `–j` : multithread 加速 (Optional) (arg: int)

5. **Clone NVmain**
    > [!CAUTION]
    > 把 NVmain 跟 gem5 放到同一個目錄下

    > [!NOTE]
    > 或者使用 `git submodule` 也可以
    ```bash
    git clone https://github.com/SEAL-UCSB/NVmain
    ```

6. **Comment `NVmain/SConscript`**
    > 把 36 行的 `from gem5_scons import Transform` 註解掉並存檔

7. **Compile NVmain**
    > [!CAUTION]
    > 在 NVmain 目錄下
    ```bash
    scons --build-type=fast
    ```

8. **Modify `gem5/configs/common/Options.py`**
    > 第 133 行加入以下程式並存檔
    ```py
    for arg in sys.argv:
      if arg[:9] == "--nvmain-":
        parser.add_option(arg, type="string", default="NULL", help="Set NVMain configuration value for a parameter")
    ```

9.  **Uncomment `NVmain/SConscript`**
    > 還原前面註解掉的 `from gem5_scons import Transform`

10. **Compile Together**
    > [!CAUTION]
    > 在 gen5 目錄下
    ```bash
    scons EXTRAS=../NVmain build/X86/gem5.opt
    ```


## [⬆️][0] Q2. Enable L3 cache

+ 修改檔案
  + [x] `gem5/configs/common/Options.py`
  + [x] `gem5/configs/common/Caches.py`
  + [x] `gem5/configs/common/CacheConfig.py`
  + [x] `gem5/src/mem/Xbar.py`
  + [x] `gem5/src/cpu/BaseCPU.py`

+ 注意
  > [!NOTE]
  > 前面四個檔案只是增加 L3 cache 的 parameter，照著 L2 cache 的設定去做模仿就可以。

  > [!NOTE]
  > `CacheConfig.py` 需要讓 L3 cache 連接整個 Gem5 系統，這邊要注意 L2 跟 L3 這兩個 cache 的關係，要讓系統在已使用 L2 cache 的情況下才能使用 L3 cache，所以要注意修改的時候有沒有滿足這個條件。

  > [!NOTE]
  > 細節 code 的部分，同學可以上網找資源關鍵字 Gem5 L3 cache 之類的。


## [⬆️][0] Grading Criteria

+ [x] Q1. **GEM5 + NVMAIN BUILD-UP** (40%)
    + **Answer** : 按照 PowerPoint 做 

+ [x] Q2. **Enable L3 last level cache in GEM5 + NVMAIN** (15%)
    + **Answer** : Modify [these files][2]
    + **Goal** : 看到 _config.ini_ 裡面有 L3 cache 的資訊

+ [x] Q3. **Config last level cache to 2-way and full-way associative cache and test performance** (15%)
    + **Answer** : Option `--l3_assoc`. [Set to 1 indicates full-way associativity][full-assoc] (search "set to 1")
    + **Goal** : 可用 miss rate 判斷是否成功
    + **Submit** : the log files for running the _quicksort.out_ using 2-way and full-way.

+ [x] Q4. **Modify last level cache policy based on frequency based replacement policy** (15%)
    + **Answer** : Modify `gem5/configs/common/Caches.py`
    + **Submit** : the log files for running the _quicksort.out_ or _multiply.out_ using original (LRU) & frequency based (LFU).
    + **Demo** : running the _quicksort.out_

+ [x] Q5. **Test the performance of write back and write through policy based on 4-way associative cache with isscc_pcm** (15%)
    > [!IMPORTANT]
    > gem5 預設使用 write back，[write through 要自己實作][write-through-email]
    + **Answer** : Modify `gem5/src/mem/cache/base.cc` (maybe?)
    + **Goal** : 可用 write request 的數量判斷 write through 是否成功
    + **Submit** : the log files for running the _multiply.out_ using write through & write back.

+ [ ] **Bonus** (10%)
    > Design last level cache policy to reduce the energy consumption of pcm_based main memory
    + **Answer** : ?
    + **Goal** : ?
    + **Submit** : the log files for running the _hello.out_ using baseline (LRU) & modified method.


## [⬆️][0] Common Options
```bash
build/X86/gem5.opt # 可能是某種能執行 Python 的可執行檔
--help # 幫助
--debug-help # 有哪些 SimObject 可以開啟 DEBUG
--debug-flags=FLAG[,FLAG] # 指定哪些 SimObject 要開啟 DEBUG (開啟 DPRINTF 輸出) 
configs/example/se.py # Python 腳本
--help # 幫助
--cpu-type=TimingSimpleCPU # CPU 類型 (TimingSimpleCPU: Base CPI 為 1 的簡單 CPU)
--sys-clock=SYS_CLOCK # 系統 clock
--cpu-clock=CPU_CLOCK # CPU clock
--mem-type=NVMainMemory # 記憶體類型 (NVMainMemory: 使用 NVMain 模擬)
--caches # 使用 L1 快取
--l2cache # 使用 L2 快取
--l3cache # 使用 L3 快取 (自訂)
--l1d_size='128kB' # L1D 大小
--l1i_size='128kB' # L1I 大小
--l2_size='1MB' # L2 大小
--l3_size='1MB' # L3 大小
--l1d_assoc=L1D_ASSOC # L1D set
--l1i_assoc=L1I_ASSOC # L1I set
--l2_assoc=L2_ASSOC # L2 set
--l3_assoc=L3_ASSOC # L3 set
--ruby # ...
--abs-max-tick=TICKS # 限制模擬跑多少個 tick 就中止 (1 tick 預設 1 ps)
--maxinsts=MAXINSTS # 限制模擬的 CPU 跑多少個指令就中止
--options=OPTIONS # 如果 binary file 有 cmd args，在這裡餵給它 (要用雙引號刮起來)
--nvmain-config=../NVmain/Config/PCM_ISSCC_2012_4GB.config # 記憶體配置 (自訂)
--cmd tests/test-progs/hello/bin/x86/linux/hello # 讓模擬執行指定 binary file
--output=FILE # 將執行 binary file 產生的標準輸出導向某檔案
--errout=ERROUT # 將執行 binary file 產生的標準錯誤導向某檔案
```

## [⬆️][0] Diagram
```mermaid
%%{init:{"flowchart":{"defaultRenderer":"elk"}}}%%
flowchart LR
  subgraph system
    subgraph cpu
      direction TB
      icache_port
      dcache_port
      subgraph l1icache
        l1i_cpu_side["cpu_side"]
        l1i_mem_side["mem_side"]
      end
      subgraph l1dcache
        l1d_cpu_side["cpu_side"]
        l1d_mem_side["mem_side"]
      end
    end
    subgraph l2bus
      l2bus_slave["slave"]
      l2bus_master["master"]
    end
    subgraph l2cache
      l2_cpu_side["cpu_side"]
      l2_mem_side["mem_side"]
    end
    subgraph l3bus
      l3bus_slave["slave"]
      l3bus_master["master"]
    end
    subgraph l3cache
      l3_cpu_side["cpu_side"]
      l3_mem_side["mem_side"]
    end
    subgraph membus
      slave_membus["slave"]
      master_membus["master"]
    end
  end
  icache_port --- l1i_cpu_side
  dcache_port --- l1d_cpu_side
  l1i_mem_side --- l2bus_slave
  l1d_mem_side --- l2bus_slave
  l2bus_master --- l2_cpu_side
  l2_mem_side --- l3bus_slave
  l3bus_master --- l3_cpu_side
  l3_mem_side --- slave_membus
```

[0]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-outline
[1]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-setting-up-the-project
[2]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-q2-enable-l3-cache
[3]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-grading-criteria
[4]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-common-options
[5]: https://github.com/RogelioKG/Gem5-Practice?tab=readme-ov-file#%EF%B8%8F-diagram
[gem5-file]: https://gem5.googlesource.com/public/gem5/+archive/525ce650e1a5bbe71c39d4b15598d6c003cc9f9e.tar.gz
[full-assoc]: https://old.gem5.org/Coherence-Protocol-Independent_Memory_Components.html
[write-through-email]: https://www.mail-archive.com/gem5-users@gem5.org/msg16454.html