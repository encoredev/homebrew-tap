class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.5"
    checksums = {
        "darwin_arm64" => "4a00425e780efb756336b84e49c775b98757c4cec769454d9235824c1e7698d0",
        "darwin_amd64" => "1601eba4d9e46cc430121c8a85235d48edd267a5f3f414d40b66bcec749cc834",
        "linux_arm64"  => "76be35f0ee75753aa4b2ae55df937d8a522c6e29c8803622a4a88f8b61a65867",
        "linux_amd64"  => "5740824f8eb57d606e49145c80b12b9e1bc0d691d7dde06a3c26aa68094f580d",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
