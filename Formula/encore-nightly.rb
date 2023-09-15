class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230915"
    checksums = {
        "darwin_arm64" => "92ade5a5ab63b1090fa6c15174438287136eb5b17763e8df0e4178c4d3a4cbf2",
        "darwin_amd64" => "099756b70cb7b964ba97abd9f08b3b33d7fe5ab8eb4dbb1d79fe90c924a3ff81",
        "linux_arm64"  => "e1bc4e2b204f2d387dfa42659eea328204fd9dbab5150f50f8dd229ee22f83d5",
        "linux_amd64"  => "51c357cb122262d3db95b0eaaeaf37c239fe1aa5ba3b00d2441d4450545f1d40",
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
