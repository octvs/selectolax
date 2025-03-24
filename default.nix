{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  # dependencies
  cython,
  requests,
  # tests
  mock,
  pytestCheckHook,
}:
buildPythonPackage rec {
  pname = "selectolax";
  version = "0.3.28";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rushter";
    repo = "selectolax";
    tag = "v${version}";
    hash = "sha256-41KVec4LPWJitmJgmv4D2DHwanZl4LVoFk//rUv2rMU=";
    fetchSubmodules = true;
  };

  build-system = [setuptools];

  dependencies = [
    cython
  ];

  # nativeCheckInputs = [
  #   pytestCheckHook
  #   mock
  # ];

  # disabledTests = [
  #   # Require network access
  #   "test_from_feed_entry"
  #   "test_download_from_query"
  #   "test_download_tarfile_from_query"
  #   "test_download_with_custom_slugify_from_query"
  #   "test_get_short_id"
  #   "test_invalid_format_id"
  #   "test_invalid_id"
  #   "test_legacy_ids"
  #   "test_max_results"
  #   "test_missing_title"
  #   "test_no_duplicates"
  #   "test_nonexistent_id_in_list"
  #   "test_offset"
  #   "test_query_page_count"
  #   "test_result_shape"
  #   "test_search_results_offset"
  # ];

  pythonImportsCheck = ["selectolax"];

  meta = {
    description = "Python binding to Modest and Lexbor engines (fast HTML5 parser with CSS selectors).";
    homepage = "https://github.com/rushter/selectolax";
    changelog = "https://github.com/rushter/selectolax/releases/tag/${version}";
    license = lib.licenses.mit;
    maintainers = [lib.maintainers.octvs];
  };
}
