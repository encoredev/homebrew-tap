class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221224"
    checksums = {
        "darwin_arm64" => "2dc12f204b7a31c02514028f0562e038067e327a8082f7a988b030c1d78c0e55",
        "darwin_amd64" => "36627852b4549438601eba6a19fd1ef1d827f029d0512ec462b12b1b7beb18cf",
        "linux_arm64"  => "1aecf8ea4e292aca1ace5b94177365e2abb80865662ae6ed788febe2cdf34ce2",
        "linux_amd64"  => "aef5af5ccb8dfdd81da8dd3f51f82587cf70a01fdb23b4d23675a48e775e9452",
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
