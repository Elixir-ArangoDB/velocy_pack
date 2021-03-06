defmodule VelocyPack.Decoder.MapTest do
  use ExUnit.Case, async: true

  # todo - decode 1-byte offset with padding

  test "decode() map with 1-byte offset without padding" do
    foo = <<11, 43, 3, 51, 76, 102, 111, 111, 47, 50, 49, 54, 50, 53, 49, 57, 53, 49, 72, 50, 49, 54, 50, 53, 49, 57,
      53, 50, 75, 95, 86, 107, 51, 70, 65, 112, 87, 45, 45, 45, 3, 17, 27>>

    map = %{"_id" => "foo/21625195", "_key" => "21625195", "_rev" => "_Vk3FApW---"}

    assert VelocyPack.decode(foo) === {:ok, map, ""}
  end

  test "decode() map with 2-byte offset and zero-byte padding" do
    foo = <<12, 44, 1, 15, 0, 0, 0, 0, 0, 68, 117, 115, 101, 114, 24, 72, 100, 97, 116, 97, 98, 97, 115, 101, 71, 95,
      115, 121, 115, 116, 101, 109, 67, 117, 114, 108, 76, 47, 95, 97, 100, 109, 105, 110, 47, 101, 99, 104, 111, 72,
      112, 114, 111, 116, 111, 99, 111, 108, 67, 118, 115, 116, 70, 115, 101, 114, 118, 101, 114, 11, 31, 2, 71, 97,
      100, 100, 114, 101, 115, 115, 73, 49, 50, 55, 46, 48, 46, 48, 46, 49, 68, 112, 111, 114, 116, 41, 81, 33, 3, 21,
      70, 99, 108, 105, 101, 110, 116, 11, 51, 3, 71, 97, 100, 100, 114, 101, 115, 115, 73, 49, 50, 55, 46, 48, 46, 48,
      46, 49, 68, 112, 111, 114, 116, 41, 53, 201, 66, 105, 100, 79, 49, 52, 57, 55, 50, 49, 49, 57, 54, 48, 53, 49, 54,
      53, 48, 3, 29, 21, 73, 105, 110, 116, 101, 114, 110, 97, 108, 115, 10, 70, 112, 114, 101, 102, 105, 120, 65, 47,
      71, 104, 101, 97, 100, 101, 114, 115, 10, 75, 114, 101, 113, 117, 101, 115, 116, 84, 121, 112, 101, 68, 80, 79,
      83, 84, 75, 114, 101, 113, 117, 101, 115, 116, 66, 111, 100, 121, 67, 49, 50, 51, 74, 112, 97, 114, 97, 109, 101,
      116, 101, 114, 115, 10, 70, 115, 117, 102, 102, 105, 120, 1, 68, 112, 97, 116, 104, 65, 47, 78, 114, 97, 119, 82,
      101, 113, 117, 101, 115, 116, 66, 111, 100, 121, 2, 8, 40, 49, 40, 50, 40, 51, 100, 0, 15, 0, 178, 0, 158, 0, 220,
      0, 240, 0, 169, 0, 49, 0, 247, 0, 204, 0, 187, 0, 62, 0, 232, 0, 32, 0, 9, 0>>

    map = %{
      "client" => %{"address" => "127.0.0.1", "id" => "149721196051650", "port" => 51509},
      "database" => "_system",
      "headers" => %{},
      "internals" => %{},
      "parameters" => %{},
      "path" => "/",
      "prefix" => "/",
      "protocol" => "vst",
      "rawRequestBody" => '123',
      "requestBody" => "123",
      "requestType" => "POST",
      "server" => %{"address" => "127.0.0.1", "port" => 8529},
      "suffix" => [],
      "url" => "/_admin/echo",
      "user" => nil
    }

    assert VelocyPack.decode(foo) == {:ok, map, ""}
  end

  # todo - decode 2-byte offset without padding

  test "decode() compact map" do
    foo = <<0x14, 0xcd, 0x01, 0x47, 0x71, 0x75, 0x65, 0x72, 0x69, 0x65, 0x73, 0x13, 0xc1, 0x01, 0x14, 0xbd, 0x01, 0x44,
      0x6e, 0x61, 0x6d, 0x65, 0x43, 0x66, 0x6f, 0x6f, 0x49, 0x70, 0x61, 0x72, 0x61, 0x6d, 0x65, 0x74, 0x65, 0x72, 0x0a,
      0x45, 0x76, 0x61, 0x6c, 0x75, 0x65, 0xbf, 0x96, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x4f, 0x52, 0x20,
      0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x20, 0x49, 0x4e, 0x20, 0x62, 0x6c, 0x61,
      0x68, 0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x73, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x46, 0x4f, 0x52, 0x20,
      0x79, 0x61, 0x64, 0x64, 0x61, 0x79, 0x61, 0x64, 0x64, 0x61, 0x79, 0x61, 0x64, 0x64, 0x61, 0x20, 0x49, 0x4e, 0x20,
      0x4f, 0x55, 0x54, 0x42, 0x4f, 0x55, 0x4e, 0x44, 0x20, 0x79, 0x61, 0x64, 0x64, 0x61, 0x79, 0x61, 0x64, 0x64, 0x61,
      0x79, 0x61, 0x64, 0x64, 0x61, 0x73, 0x20, 0x69, 0x6e, 0x5f, 0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x62,
      0x6c, 0x61, 0x68, 0x73, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x52, 0x45, 0x54, 0x55, 0x52, 0x4e,
      0x20, 0x7b, 0x79, 0x61, 0x64, 0x64, 0x61, 0x79, 0x61, 0x64, 0x64, 0x61, 0x79, 0x61, 0x64, 0x64, 0x61, 0x2c, 0x20,
      0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x62, 0x6c, 0x61, 0x68, 0x7d, 0x03, 0x01, 0x01>>

    map = %{
     "queries" => [%{
        "name" => "foo",
        "parameter" => %{},
        "value" => "FOR blahblahblah IN blahblahblahs\n    FOR yaddayaddayadda IN OUTBOUND yaddayaddayaddas "
          <> "in_blahblahblahs\n        RETURN {yaddayaddayadda, blahblahblah}"
     }]
   }

    assert VelocyPack.decode(foo) == {:ok, map, ""}
  end

  # todo - test translating arango keys
end
