require 'spec_helper'

RSpec.describe JsonKit::Helper do

  let(:hash_with_arrays) do
    { array1: [hash,hash], array2: [1,2,3,4] }
  end

  describe '#to_json' do

    let(:hash) do
      { key1: 'value1' }
    end

    let(:class_instance) do
      TestEntity.new.tap do |entity|
        entity.text = 'abc'
        entity.numeric = 5
      end
    end

    let(:hash_array) do
      [hash,hash,hash]
    end

    let(:class_instance_array) do
      [class_instance, class_instance, class_instance]
    end

    context 'Hash' do
      it 'should create a json string' do
        json = subject.to_json(hash)
        expect(json).to eq('{"key1":"value1"}')
      end

      context 'with nested arrays' do
        it 'should create a json string' do
          json = subject.to_json(hash_with_arrays)
          expect(json).to eq('{"array1":[{"key1":"value1"},{"key1":"value1"}],"array2":[1,2,3,4]}')
        end
      end
    end

    context 'String' do
      it 'should return the string and not json serialize it' do
        string = 'abc'
        value = subject.to_json(string)
        expect(value).to eq(string)
      end
    end

    context 'Class Instance' do
      it 'should create a json string' do
        json = subject.to_json(class_instance)
        expect(json).to eq('{"text":"abc","numeric":5}')
      end
    end

    context 'Array' do
      context 'of Hashes' do
        it 'should create a json string' do
          json = subject.to_json(hash_array)
          expect(json).to eq('[{"key1":"value1"},{"key1":"value1"},{"key1":"value1"}]')
        end
      end

      context 'of class instances' do
        it 'should create a json string' do
          json = subject.to_json(class_instance_array)
          expect(json).to eq('[{"text":"abc","numeric":5},{"text":"abc","numeric":5},{"text":"abc","numeric":5}]')
        end
      end
    end

  end

  describe '#from_json' do
    let(:json) do
      return '{"text":"abc","numeric":5}'
    end

    let(:json_array) do
      return '[{"text":"abc","numeric":5},{"text":"def","numeric":6}]'
    end

    let(:json_hash_with_arrays) do
      '{"array1":[{"key1":"value1"},{"key1":"value1"}],"array2":[1,2,3,4]}'
    end

    context 'when no klass is specified' do

      it 'should return a hash form the json' do
        expect(subject.from_json(json)).to eq({ text: 'abc', numeric: 5 })
      end

      it 'should return an array of hashes from the json' do
        array = subject.from_json(json_array)
        expect(array).to be_a(Array)
        expect(array.length).to eq(2)
        expect(array[0]).to eq({ text: 'abc', numeric: 5 })
        expect(array[1]).to eq({ text: 'def', numeric: 6 })
      end

      it 'should return a hash with nested arrays from the json' do
        hash = subject.from_json(json_hash_with_arrays)
        expect(hash[:array1].length).to eq(2)
        expect(hash[:array1][0][:key1]).to eq('value1')
        expect(hash[:array2].length).to eq(4)
        expect(hash[:array2][0]).to eq(1)
        expect(hash[:array2][1]).to eq(2)
        expect(hash[:array2][2]).to eq(3)
        expect(hash[:array2][3]).to eq(4)
      end

    end

    context 'when a klass is specified' do
      it 'should return an instance of the class populated by the json' do
        obj = subject.from_json(json, TestEntity)
        expect(obj).to be_a(TestEntity)
        expect(obj.text).to eq('abc')
        expect(obj.numeric).to eq(5)
      end

      it 'should return an array of instances populated from the json' do
        array = subject.from_json(json_array, TestEntity)
        expect(array).to be_a(Array)
        expect(array.length).to eq(2)
        expect(array[0]).to be_a(TestEntity)
        expect(array[0].text).to eq('abc')
        expect(array[0].numeric).to eq(5)
        expect(array[1]).to be_a(TestEntity)
        expect(array[1].text).to eq('def')
        expect(array[1].numeric).to eq(6)
      end
    end

  end

end