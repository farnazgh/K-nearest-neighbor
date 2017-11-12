tic

k=2;

data = importdata('data.txt',',');

num_train_data = round(0.8*size(data,1));
num_test_data = size(data,1) - num_train_data;


sum_accuracy =0;
accuracy_vector = [];

for i=1:30
  rp = randperm(size(data,1));
  train_data = data(rp(1:num_train_data),:); 
  test_data = data(rp(num_train_data+1:num_train_data+num_test_data),:);
  
  %for each test data
  num_correct =0;
  for j=1:num_test_data
    sample = test_data(j,:);
    
    
    %calculate Euclidean distance
    %1 first
    first_nearest_sample_index = 0;
    first_nearest_sample__distance = -1;
    
    for k=1:num_train_data
      r = train_data(k,:);
      %%Euclidean
      %Edis = sqrt(sum((sample - r) .^ 2)); 
      
      %%cosine
      norm_s = sqrt(sum((sample).^2));
      norm_r = sqrt(sum((r).^2));
      Edis = 1- ( sum(sample .* r)/(norm_s*norm_r) );
      
      if (first_nearest_sample__distance == -1)||(first_nearest_sample__distance ~= -1 && Edis < first_nearest_sample__distance)
        first_nearest_sample__distance = Edis;
        first_nearest_sample_index = k;
      end
    end
    
    %2 second 
    second_nearest_sample_index = 0;
    second_nearest_sample__distance = -1;
    
    for k=1:num_train_data
    
      if(k == first_nearest_sample_index) continue; end
      
      r = train_data(k,:);
      %%Euclidean
      %Edis = sqrt(sum((sample - r) .^ 2)); 
      
      %%cosine
      norm_s = sqrt(sum((sample).^2));
      norm_r = sqrt(sum((r).^2));
      Edis = 1- ( sum(sample .* r)/(norm_s*norm_r) ); 
      
      if (second_nearest_sample__distance == -1)||(second_nearest_sample__distance ~= -1 && Edis < second_nearest_sample__distance)
        second_nearest_sample__distance = Edis;
        second_nearest_sample_index = k;
      end
    end
    
    %3 third 
    third_nearest_sample_index = 0;
    third_nearest_sample__distance = -1;
    
    for k=1:num_train_data
    
      if(k == first_nearest_sample_index || k == second_nearest_sample_index) continue; end
      
      r = train_data(k,:);
      %%Euclidean
      %Edis = sqrt(sum((sample - r) .^ 2)); 
      
      %%cosine
      norm_s = sqrt(sum((sample).^2));
      norm_r = sqrt(sum((r).^2));
      Edis = 1- ( sum(sample .* r)/(norm_s*norm_r) );
      
      if (third_nearest_sample__distance == -1)||(third_nearest_sample__distance ~= -1 && Edis < third_nearest_sample__distance)
        third_nearest_sample__distance = Edis;
        third_nearest_sample_index = k;
      end
    end
    
    
    if((sample(1) == train_data(second_nearest_sample_index ,1)) && (sample(1) == train_data(first_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif ((sample(1) == train_data(third_nearest_sample_index ,1)) && (sample(1) == train_data(first_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif ((sample(1) == train_data(second_nearest_sample_index ,1)) && (sample(1) == train_data(third_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif (sample(1) == train_data(first_nearest_sample_index ,1))
       num_correct = num_correct +1;
    end
    
  end
  
  accuracy = num_correct / num_test_data;
  sum_accuracy = sum_accuracy + accuracy;
  
  accuracy_vector = [accuracy_vector accuracy];
  
end


avg_accuracy = sum_accuracy / 30

var_accuracy = sum((accuracy_vector - avg_accuracy).^ 2)

toc