class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221212"
    checksums = {
        "darwin_arm64" => "b9a041aacdefdb0973cd34070319df6a032a9ae56b86adaca7db57f0eb03931f",
        "darwin_amd64" => "b67a07fa69014d593337567c4934775bf5b2eb75c567ca6a55ebffe1323fda73",
        "linux_arm64"  => "b0f0744f014c8366f4afbddfb7278ab4421045eab21cffc09d9ced6c8d434a87",
        "linux_amd64"  => "83d3e2f7532c42648f816ce0b7c782d64abe78b59b44f4f2aea72291e64f61e9",
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
