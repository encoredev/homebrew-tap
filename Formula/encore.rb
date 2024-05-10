class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.0"
    checksums = {
        "darwin_arm64" => "54ff87933d68d5f063248174ed93ac54cf577bf86439c126cdad1ef13d99ed26",
        "darwin_amd64" => "916f4dd1e0ce06191e287c2484bda6d188ddef6952abe31c8e5f8099d5339060",
        "linux_arm64"  => "3fd76285903569df54137770a37d79570850f1142a2af7e4eb6406733d666c28",
        "linux_amd64"  => "393255995d6959c4b3110eb06a788e4b762a2259ccc1849b939c727a80a1e530",
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
