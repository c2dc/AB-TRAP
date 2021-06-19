
    // !!! This file is generated using emlearn !!!

    #include <eml_trees.h>
    

EmlTreesNode scan_nodes[73] = {
  { 2, 64.5, 1, 72 },
  { 6, 0.5, 2, 63 },
  { 5, 38.0, 3, 53 },
  { 1, 0.5, 4, 30 },
  { 7, 0.5, 5, 18 },
  { 2, 40.5, 6, 17 },
  { 13, 506.5, 7, 8 },
  { -1, 0, -1, -1 },
  { 13, 1300.0, 9, 16 },
  { 13, 1024.5, 10, 14 },
  { 0, 58934.5, 11, 13 },
  { 0, 20091.5, 12, 12 },
  { -1, 1, -1, -1 },
  { 0, 58937.0, 7, 12 },
  { 8, 0.5, 7, 15 },
  { 3, 4.0, 12, 7 },
  { 13, 1433.0, 7, 7 },
  { 13, 12.5, 7, 7 },
  { 13, 520.5, 19, 20 },
  { 13, 506.5, 7, 12 },
  { 13, 65524.0, 21, 28 },
  { 2, 42.0, 22, 25 },
  { 13, 1064.0, 23, 7 },
  { 3, 2.0, 24, 7 },
  { 0, 60742.0, 7, 7 },
  { 13, 1026.0, 26, 7 },
  { 3, 4.0, 27, 7 },
  { 13, 933.0, 7, 12 },
  { 3, 4.0, 29, 7 },
  { 5, 22.0, 12, 7 },
  { 13, 0.5, 31, 43 },
  { 0, 59.5, 32, 36 },
  { 10, 0.5, 33, 35 },
  { 3, 1.0, 12, 34 },
  { 3, 5.0, 7, 7 },
  { 7, 0.5, 7, 7 },
  { 0, 38766.5, 7, 37 },
  { 0, 38841.0, 12, 38 },
  { 0, 41467.0, 39, 40 },
  { 0, 41284.0, 7, 12 },
  { 0, 60709.5, 41, 42 },
  { 10, 0.5, 7, 7 },
  { 0, 60827.0, 12, 7 },
  { 4, 18.5, 44, 51 },
  { 13, 28944.0, 7, 45 },
  { 13, 29008.0, 46, 47 },
  { 0, 26421.0, 7, 12 },
  { 8, 0.5, 48, 50 },
  { 0, 51143.0, 7, 49 },
  { 0, 51161.0, 12, 7 },
  { 2, 46.0, 7, 12 },
  { 13, 21780.0, 7, 52 },
  { 13, 46454.0, 12, 7 },
  { 13, 15749.0, 7, 54 },
  { 13, 64520.0, 55, 62 },
  { 0, 11.0, 7, 56 },
  { 13, 16472.0, 57, 58 },
  { 2, 62.0, 7, 12 },
  { 13, 64157.0, 7, 59 },
  { 0, 55526.5, 60, 12 },
  { 0, 55379.5, 61, 12 },
  { 0, 50700.0, 12, 12 },
  { 7, 0.5, 7, 7 },
  { 13, 511.5, 7, 64 },
  { 0, 2.0, 7, 65 },
  { 13, 16498.0, 66, 7 },
  { 3, 4.0, 67, 7 },
  { 10, 0.5, 12, 68 },
  { 13, 1023.5, 7, 69 },
  { 13, 15616.0, 70, 12 },
  { 13, 1024.5, 71, 7 },
  { 1, 0.5, 12, 7 },
  { 9, 0.5, 7, 7 } 
};

int32_t scan_tree_roots[1] = { 0 };

EmlTrees scan = {
        73,
        scan_nodes,	  
        1,
        scan_tree_roots,
    };

static inline int32_t scan_predict_tree_0(const float *features, int32_t features_length) {
          if (features[2] < 64.5) {
              if (features[6] < 0.5) {
                  if (features[5] < 38.0) {
                      if (features[1] < 0.5) {
                          if (features[7] < 0.5) {
                              if (features[2] < 40.5) {
                                  if (features[13] < 506.5) {
                                      return 0;
                                  } else {
                                      if (features[13] < 1300.0) {
                                          if (features[13] < 1024.5) {
                                              if (features[0] < 58934.5) {
                                                  if (features[0] < 20091.5) {
                                                      return 1;
                                                  } else {
                                                      return 1;
                                                  }
                                              } else {
                                                  if (features[0] < 58937.0) {
                                                      return 0;
                                                  } else {
                                                      return 1;
                                                  }
                                              }
                                          } else {
                                              if (features[8] < 0.5) {
                                                  return 0;
                                              } else {
                                                  if (features[3] < 4.0) {
                                                      return 1;
                                                  } else {
                                                      return 0;
                                                  }
                                              }
                                          }
                                      } else {
                                          if (features[13] < 1433.0) {
                                              return 0;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  }
                              } else {
                                  if (features[13] < 12.5) {
                                      return 0;
                                  } else {
                                      return 0;
                                  }
                              }
                          } else {
                              if (features[13] < 520.5) {
                                  if (features[13] < 506.5) {
                                      return 0;
                                  } else {
                                      return 1;
                                  }
                              } else {
                                  if (features[13] < 65524.0) {
                                      if (features[2] < 42.0) {
                                          if (features[13] < 1064.0) {
                                              if (features[3] < 2.0) {
                                                  if (features[0] < 60742.0) {
                                                      return 0;
                                                  } else {
                                                      return 0;
                                                  }
                                              } else {
                                                  return 0;
                                              }
                                          } else {
                                              return 0;
                                          }
                                      } else {
                                          if (features[13] < 1026.0) {
                                              if (features[3] < 4.0) {
                                                  if (features[13] < 933.0) {
                                                      return 0;
                                                  } else {
                                                      return 1;
                                                  }
                                              } else {
                                                  return 0;
                                              }
                                          } else {
                                              return 0;
                                          }
                                      }
                                  } else {
                                      if (features[3] < 4.0) {
                                          if (features[5] < 22.0) {
                                              return 1;
                                          } else {
                                              return 0;
                                          }
                                      } else {
                                          return 0;
                                      }
                                  }
                              }
                          }
                      } else {
                          if (features[13] < 0.5) {
                              if (features[0] < 59.5) {
                                  if (features[10] < 0.5) {
                                      if (features[3] < 1.0) {
                                          return 1;
                                      } else {
                                          if (features[3] < 5.0) {
                                              return 0;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  } else {
                                      if (features[7] < 0.5) {
                                          return 0;
                                      } else {
                                          return 0;
                                      }
                                  }
                              } else {
                                  if (features[0] < 38766.5) {
                                      return 0;
                                  } else {
                                      if (features[0] < 38841.0) {
                                          return 1;
                                      } else {
                                          if (features[0] < 41467.0) {
                                              if (features[0] < 41284.0) {
                                                  return 0;
                                              } else {
                                                  return 1;
                                              }
                                          } else {
                                              if (features[0] < 60709.5) {
                                                  if (features[10] < 0.5) {
                                                      return 0;
                                                  } else {
                                                      return 0;
                                                  }
                                              } else {
                                                  if (features[0] < 60827.0) {
                                                      return 1;
                                                  } else {
                                                      return 0;
                                                  }
                                              }
                                          }
                                      }
                                  }
                              }
                          } else {
                              if (features[4] < 18.5) {
                                  if (features[13] < 28944.0) {
                                      return 0;
                                  } else {
                                      if (features[13] < 29008.0) {
                                          if (features[0] < 26421.0) {
                                              return 0;
                                          } else {
                                              return 1;
                                          }
                                      } else {
                                          if (features[8] < 0.5) {
                                              if (features[0] < 51143.0) {
                                                  return 0;
                                              } else {
                                                  if (features[0] < 51161.0) {
                                                      return 1;
                                                  } else {
                                                      return 0;
                                                  }
                                              }
                                          } else {
                                              if (features[2] < 46.0) {
                                                  return 0;
                                              } else {
                                                  return 1;
                                              }
                                          }
                                      }
                                  }
                              } else {
                                  if (features[13] < 21780.0) {
                                      return 0;
                                  } else {
                                      if (features[13] < 46454.0) {
                                          return 1;
                                      } else {
                                          return 0;
                                      }
                                  }
                              }
                          }
                      }
                  } else {
                      if (features[13] < 15749.0) {
                          return 0;
                      } else {
                          if (features[13] < 64520.0) {
                              if (features[0] < 11.0) {
                                  return 0;
                              } else {
                                  if (features[13] < 16472.0) {
                                      if (features[2] < 62.0) {
                                          return 0;
                                      } else {
                                          return 1;
                                      }
                                  } else {
                                      if (features[13] < 64157.0) {
                                          return 0;
                                      } else {
                                          if (features[0] < 55526.5) {
                                              if (features[0] < 55379.5) {
                                                  if (features[0] < 50700.0) {
                                                      return 1;
                                                  } else {
                                                      return 1;
                                                  }
                                              } else {
                                                  return 1;
                                              }
                                          } else {
                                              return 1;
                                          }
                                      }
                                  }
                              }
                          } else {
                              if (features[7] < 0.5) {
                                  return 0;
                              } else {
                                  return 0;
                              }
                          }
                      }
                  }
              } else {
                  if (features[13] < 511.5) {
                      return 0;
                  } else {
                      if (features[0] < 2.0) {
                          return 0;
                      } else {
                          if (features[13] < 16498.0) {
                              if (features[3] < 4.0) {
                                  if (features[10] < 0.5) {
                                      return 1;
                                  } else {
                                      if (features[13] < 1023.5) {
                                          return 0;
                                      } else {
                                          if (features[13] < 15616.0) {
                                              if (features[13] < 1024.5) {
                                                  if (features[1] < 0.5) {
                                                      return 1;
                                                  } else {
                                                      return 0;
                                                  }
                                              } else {
                                                  return 0;
                                              }
                                          } else {
                                              return 1;
                                          }
                                      }
                                  }
                              } else {
                                  return 0;
                              }
                          } else {
                              return 0;
                          }
                      }
                  }
              }
          } else {
              if (features[9] < 0.5) {
                  return 0;
              } else {
                  return 0;
              }
          }
        }
        

int32_t scan_predict(const float *features, int32_t features_length) {

        int32_t votes[2] = {0,};
        int32_t _class = -1;

        _class = scan_predict_tree_0(features, features_length); votes[_class] += 1;
    
        int32_t most_voted_class = -1;
        int32_t most_voted_votes = 0;
        for (int32_t i=0; i<2; i++) {

            if (votes[i] > most_voted_votes) {
                most_voted_class = i;
                most_voted_votes = votes[i];
            }
        }
        return most_voted_class;
    }
    