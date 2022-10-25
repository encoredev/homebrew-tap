class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.9.2"
    checksums = {
        "darwin_arm64" => "d1343529dddda3f31728b4fede060584d1461ef88d951d894ed7cb82b6713288",
        "darwin_amd64" => "c2610bcffd99eb072f56c4b4b60ed2debb3afc2b4c7dee79b8db1868bd32cfea",
        "linux_arm64"  => "a3d2e062bcab5ae226effee906964ff82c397e37c8d4662b3f8d30b435f42bda",
        "linux_amd64"  => "09648ecad04aeb1cd59a45bda332b4a7c4e304986687391f2855e6ba6c68b85c",
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
